-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Snapshot {{{

local in_headless = #vim.api.nvim_list_uis() == 0

local packer = require("packer")

local snapshot_path = join_paths(get_cache_dir(), "snapshots")
local snapshot_name = "default.json"
local snapshot_file = join_paths(snapshot_path, snapshot_name)

local function sync_done()
    vim.notify("Sync Snapshot and Compile completed!", vim.log.levels.INFO, { title = "Packer Sync" })
    if in_headless then
        vim.cmd("q")
    end
end

-- ## Compile {{{

local function packer_compile()
    -- Take snapshot
    packer.compile()

    -- Post snapshot, bin to sort_snapshot
    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerCompileDone',
        callback = sync_done,
    })
end

vim.api.nvim_create_user_command(
    "Compile",
    packer_compile,
    { nargs = 0 }
)
-- }}}

-- ## Snapshot {{{

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

    -- Take snapshot
    packer.snapshot("default.json")

    -- Post snapshot, bin to sort_snapshot
    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerSnapshotDone',
        callback = post_snapshot,
    })
end

vim.api.nvim_create_user_command(
    "Snapshot",
    packer_snapshot,
    { nargs = 0 }
)
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
