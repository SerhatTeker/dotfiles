-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false

-- Additional Plugins
lvim.plugins = {
    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    -- Persistence
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
            }
        end,
    },
    -- Lastplace
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },
    {
        'numToStr/Navigator.nvim',
        config = function()
            require('Navigator').setup()
        end,
    },
    -- Fugitive
    {
        "tpope/vim-fugitive",
        cmd = {
            "G",
            "Git",
            "Gdiffsplit",
            "Gvdiffsplit",
            "Gread",
            "Gwrite",
            "Ggrep",
            "GMove",
            "GDelete",
            "GBrowse",
            "GRemove",
            "GRename",
            "Glgrep",
            "Gedit"
        },
        ft = { "fugitive" }
    },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    -- Tokyonight
    { "folke/tokyonight.nvim" },
    -- Harpoon
    { "ThePrimeagen/harpoon" },
    -- Trim
    {
        "cappyzawa/trim.nvim",
        config = function()
            require('trim').setup({
                disable = { "markdown" },

                patterns = {
                    [[%s/\s\+$//e]], -- remove unwanted spaces
                    [[%s/\($\n\s*\)\+\%$//]], -- trim last line
                    [[%s/\%^\n\+//]], -- trim first line
                    -- [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
                },
            })
        end,
    },
    -- Shade, dim InactiveWindow
    { "sunjon/shade.nvim" },
}
