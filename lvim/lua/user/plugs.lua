-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
lvim.builtin.dap.active = true -- (default: false)


-- Additional Plugins
lvim.plugins = {
    -- # Core
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
    -- Navigator
    {
        'numToStr/Navigator.nvim',
        config = function()
            require('Navigator').setup()
        end,
    },
    -- TPope/Fugitive
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
    -- TPope/Repeat
    { "tpope/vim-repeat" },
    -- TPope/surround
    {
        "tpope/vim-surround",
        keys = { "c", "d", "y" }
        -- make sure to change the value of `timeoutlen` if it's not triggering
        -- correctly, see https://github.com/tpope/vim-surround/issues/117
        -- setup = function()
        --  vim.o.timeoutlen = 500
        -- end
    },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },
    -- # Additional
    -- ## Colorschemes
    { "folke/tokyonight.nvim" },
    { "Mofiqul/vscode.nvim" },
    -- { "ellisonleao/gruvbox.nvim" }, -- alternative gruvbox
    { "sainnhe/gruvbox-material" },
    -- { 'navarasu/onedark.nvim' }, -- alternative onedark
    {
        "SerhatTeker/neodarker.nvim",
        config = function()
            pcall(function()
                if lvim and lvim.colorscheme == "neodarker" then
                    require("neodarker").setup()
                    lvim.builtin.lualine.options.theme = "neodarker"
                end
            end)
        end,
    },
    -- ## Use
    -- Harpoon
    { "ThePrimeagen/harpoon" },
    -- Trim
    {
        "SerhatTeker/trim.nvim",
        event = "BufWritePre",
        config = function()
            require('trim').setup()
        end,
    },
    -- Shade, dim InactiveWindow
    -- INFO: Disabled, not working with sessions
    -- https://github.com/sunjon/Shade.nvim/issues/2
    -- { "sunjon/shade.nvim" },
    -- SymbolsOutline
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
    },
}
