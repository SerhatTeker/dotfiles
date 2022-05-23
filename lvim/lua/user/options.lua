-- # General
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50"
vim.opt.cmdheight = 1

-- # Folding
vim.opt.foldenable = false  -- disable folding on open
vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

-- # LunarVim
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.use_icons = true
