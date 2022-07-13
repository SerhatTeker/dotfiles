-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Packer Sync and Snapshot {{{

local packer = require("packer")

local snapshot_path = join_paths(get_cache_dir(), "snapshots")
local snapshot_name = "default.json"
local snapshot_file = join_paths(snapshot_path, snapshot_name)

local function sync_done()
    local in_headless = #vim.api.nvim_list_uis() == 0 -- TODO: Make global

    vim.notify("Sync Snapshot and Compile completed!", vim.log.levels.INFO, { title = "Packer Sync" })
    if in_headless then
        vim.cmd("q")
    end
end

-- ## Snapshot {{{

-- Hacky and ugly way to get "PackerSnapshotDone" until PR merged
-- Add PackerSnapshotDone commit from #898 PR
local function overwrite_packer()
    local install_path = join_paths(os.getenv("XDG_DATA_HOME"), "lunarvim", "site", "pack", "packer", "start", "packer.nvim")

    vim.fn.system { "git", "-C", install_path, "fetch", "origin", "pull/898/head" }
    vim.fn.system { "git", "-C", install_path, "cherry-pick", "e070db37f5ad3733a790912cb247c1036888d473" }

    -- # with vim api
    -- local fetch = "!git " .. "-C " .. install_path .. " fetch" .. " origin" .. " pull/898/head"
    -- local cherry = "!git " .. "-C " .. install_path .. " cherry-pick " .. "e070db37f5ad3733a790912cb247c1036888d473"
    -- vim.api.nvim_command(fetch)
    -- vim.api.nvim_command(cherry)
end

local function sort_snapshot()
    if vim.fn.filereadable(snapshot_file) == 1 then
        local tmp = join_paths(snapshot_path, "temp_default.json")
        local cmd = "jq --sort-keys . " .. snapshot_file .. " > " .. tmp
        os.execute(cmd)
        os.rename(tmp, snapshot_file)
    else
        vim.notify("Snapshot file not found!", vim.log.levels.ERROR, { title = "sort_snapshot()" })
    end
end

local function post_snapshot()
    sort_snapshot()

    -- Copy to dotfiles
    local dotfile_path = os.getenv("HOME") .. "/dotfiles/lvim/snapshots"
    os.execute(string.format("cp %s %s", snapshot_file, dotfile_path))

    sync_done()
end

local function packer_snapshot()
    vim.cmd([[
            set shortmess=lFtncIiTOofx
            set cmdheight=1
    ]])

    -- Delete if exists
    if vim.fn.filereadable(snapshot_file) then
        os.execute("rm " .. snapshot_file)
    end

    -- Must be above snapshot(), 'PackerSnapshotDone' cmd comes from this commit
    overwrite_packer()

    -- Take snapshot
    packer.snapshot("default.json")

    -- Post snapshot, bin to sort_snapshot
    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerSnapshotDone',
        callback = post_snapshot,
    })
end

-- }}}

-- ## Sync {{{

local function packer_sync()
    vim.cmd([[
            set shortmess=
            set cmdheight=2
    ]])

    packer.sync()

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerComplete',
        callback = packer_snapshot,
    })
end

-- }}}

-- Use complete Packer Sync
-- PackerSync, PackerSnapshot, PackerCompile and backup snapshot file to $dotfiles
vim.api.nvim_create_user_command(
    "Sync",
    packer_sync,
    { nargs = 0 }
)
-- }}}
