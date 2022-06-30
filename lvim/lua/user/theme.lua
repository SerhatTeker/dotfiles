-- # Colorschemes


-- ## Neodarker
lvim.colorscheme = "neodarker"

-- require("neodarker").setup()
-- vim.cmd [[colorscheme neodarker]]
-- vim.colorscheme = "neodarker"
-- lvim.builtin.lualine.options.theme = "onedark"

-- ## Onedark
-- lvim.colorscheme = "onedark"

-- require('onedark').setup {
--     style = "darker"
-- }
-- require("onedark").load()

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

if lvim.colorscheme == "vscode" then
    vim.g.vscode_style = "dark"
end
-- }}}

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
