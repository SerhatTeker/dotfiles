-- # General
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50"
vim.opt.cmdheight = 1
-- tabs, spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.softtabstop = 4 -- how many columns (=spaces) the cursor moves right when you press <Tab>

-- # Folding
vim.opt.foldenable = false -- disable folding on open
vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

-- # LunarVim
lvim.log.level = "warn"
lvim.use_icons = true
-- Format files on save
lvim.format_on_save = {
    pattern = {
        "*.lua",
        "*.sh",
        "*.vim",
        "*.go",
        "*.js",
        "*.jsx",
    },
}
