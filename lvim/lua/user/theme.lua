-- # Colorschemes

-- ## Neodarker
lvim.colorscheme = "neodarker"
-- require("neodarker").setup()
-- vim.colorscheme = "neodarker"

-- require("neodarker").setup()
-- lvim.builtin.lualine.options.theme = "onedark"

-- ## Gruvbox
-- lvim.colorscheme = "gruvbox"

-- ## Gruvbox Material
-- NOTE: the configuration options should be placed before `colorscheme gruvbox-material`

-- hard | medium | soft
-- vim.api.nvim_set_var("gruvbox_material_background", "hard")
-- -- material | mix | original
-- vim.api.nvim_set_var("gruvbox_material_foreground", "original")

-- lvim.colorscheme = "gruvbox-material"

-- ## Tokyonight
-- lvim.colorscheme = "tokyonight"

-- ## Vscode {{{

-- lvim.colorscheme = "vscode"

-- Switching theme
-- :lua require('vscode').change_style("light")
-- :lua require('vscode').change_style("dark")

if lvim.colorscheme ~= "vscode" then
    vim.g.vscode_style = "dark"
end
-- }}}

-- ## Onedarker {{{

-- lvim.colorscheme = "onedarker"

-- local C = require("onedarker.palette")
-- local colors = {
--   sign_add = "#587c0c",
--   sign_change = "#0c7d9d",
--   sign_delete = "#94151b",
--   diff_add = "#303d27",
--   diff_delete = "#6e3b40",
--   diff_change = "#18344c",
--   diff_text = "#265478",
-- }

-- local Diff = {
--     DiffAdd = { fg = C.none, bg = C.sign_add },
--     DiffDelete = { fg = C.none, bg = C.sign_delete },
--     DiffChange = { fg = C.none, bg = C.sign_change, style = "bold" },
--     DiffText = { fg = C.none, bg = C.diff_text },
--     DiffAdded = { fg = C.green },
--     DiffRemoved = { fg = C.red },
--     DiffFile = { fg = C.cyan },
--     DiffIndexLine = { fg = C.gray },
-- }

-- vim.api.nvim_set_hl(0, 'DiffAdd', { fg = "NONE", bg = "#587c0c" })

-- vim.cmd [[hi DiffAdd guibg=none]]

-- https://www.reddit.com/r/neovim/comments/px8j89/highlight_command_in_initlua/
-- vim.cmd([[
-- colorscheme onedarker
-- highlight DiffAdd guibg=#587c0c
-- ]])

-- if lvim.colorscheme ~= "onedarker" then
--     vim.api.nvim_command([[
--     augroup OneDarkerDiffColors
--         autocmd VimEnter * hi DiffAdd guifg=none guibg=#587c0c
--         autocmd VimEnter * hi DiffChange guifg=none guibg=#0c7d9d
--         autocmd VimEnter * hi DiffDelete guifg=none guibg=#94151b"
--     augroup END
-- ]]   )
-- end
-- }}}

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
