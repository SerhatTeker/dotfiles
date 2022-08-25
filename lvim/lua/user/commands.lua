-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Lvim Autocommands {{{

lvim.autocommands = {
    -- disable spell set from lvim/core/autocmds.lua
    {
        "FileType",
        {
            group = "_filetype_settings",
            pattern = { "markdown" },
            command = "setlocal wrap nospell",
        },
    },
}
-- }}}

-- Packer Sync and Snapshot {{{

-- Automate manual packer sync, snapshot and copy to dotfiles:
-- 1. PackerSync
-- 2. PackerSnapshot default.json
-- 3. jq --sort-keys . $XDG_CACHE_HOME/lunarvim/snapshots/default.json > $HOME/dotfiles/lvim/snapshots/default.json

local packer = require("packer")

local snapshot_path = join_paths(get_cache_dir(), "snapshots")
local snapshot_name = "default.json"
local snapshot_file = join_paths(snapshot_path, snapshot_name)

-- ## Snapshot {{{

-- Run manual
local function post_snapshot()
    local dotfile_path = os.getenv("HOME") .. "/dotfiles/lvim/snapshots"

    local is_readable = vim.fn.filereadable(snapshot_file)
    if is_readable then
        os.execute("jq --sort-keys . " .. snapshot_file .. " > " .. join_paths(dotfile_path, "default.json"))
        vim.notify("Sync Snapshot and Compile completed!", vim.log.levels.INFO, { title = "Post Snapshot" })
    else
        vim.notify("Snapshot file not readable" .. is_readable, vim.log.levels.WARN, { title = "Post Snapshot" })
    end
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

    local a = require('packer.async')
    local async = a.sync
    local await = a.wait

    -- Take snapshot
    async(function()
        await(packer.snapshot('default.json'))
        -- await(post_snapshot())
        await(a.main)
    end)()

    -- post_snapshot() -- HACK: NW
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
