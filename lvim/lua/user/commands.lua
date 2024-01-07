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
