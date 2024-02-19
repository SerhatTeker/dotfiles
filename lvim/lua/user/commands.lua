-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })


-- Git
-- Changes have been made in your current branch that are not yet in the develop branch
vim.api.nvim_create_user_command("DiffviewUpstream", "DiffviewOpen upstream/develop...HEAD", { force = true })

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
