-- # Colorscheme
lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "gruvbox"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "vscode"

-- Vscode

-- Switching theme
-- :lua require('vscode').change_style("light")
-- :lua require('vscode').change_style("dark")


local ok, _ = pcall(require, 'vscode')
if ok then
    vim.g.vscode_style = "dark"
end

-- Onedarker
local C = require("onedarker.palette")

local Diff = {
    DiffAdd = { fg = C.none, bg = C.sign_add },
    DiffDelete = { fg = C.none, bg = C.sign_delete },
    DiffChange = { fg = C.none, bg = C.sign_change, style = "bold" },
    DiffText = { fg = C.none, bg = C.diff_text },
    DiffAdded = { fg = C.green },
    DiffRemoved = { fg = C.red },
    DiffFile = { fg = C.cyan },
    DiffIndexLine = { fg = C.gray },
}

return Diff
