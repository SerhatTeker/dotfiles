--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

require("user.options")
require("user.mappings")
require("user.plugs")
require("user.theme")

require("user.plugins.navigator")
require("user.plugins.which-key")
require("user.plugins.telescope")
require("user.plugins.which-key")
require("user.plugins.nvim-tree")
require("user.plugins.null-ls")
require("user.plugins.lualine")
require("user.plugins.bufferline")
require("user.plugins.fugitive")

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
