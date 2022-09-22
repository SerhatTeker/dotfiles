-- # Core {{{

local set = vim.opt -- set options

set.relativenumber = true -- set relative numbered lines
set.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor50"
set.cmdheight = 1
-- tabs, spaces
set.expandtab = true -- convert tabs to spaces
set.tabstop = 4 -- insert 2 spaces for a tab
set.shiftwidth = 4 -- the number of spaces inserted for each indentation
set.softtabstop = 4 -- how many columns (=spaces) the cursor moves right when you press <Tab>
-- folding
set.foldenable = false -- disable folding on open
set.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
set.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- git diff
set.diffopt:append { "vertical" } -- internal, filler, closeoff, vertical
set.fillchars = set.fillchars + 'diff: ' -- alternatives: ─ ⣿ ░
-- time
set.timeoutlen = 500
-- }}}

-- # LunarVim {{{

lvim.log.level = "warn"
lvim.use_icons = true
lvim.transparent_window = false

vim.api.nvim_create_autocmd("FileType", {
    pattern = "zsh",
    callback = function()
        -- let treesitter use bash highlight for zsh files as well
        require("nvim-treesitter.highlight").attach(0, "bash")
    end,
})

-- sometimes cmdheight messing up
vim.api.nvim_create_user_command(
    "CHeight",
    function()
        -- print(string.upper(opts.args))
        vim.opt.cmdheight = 1
    end,
    { force = true, nargs = 0 }
)
-- }}}
