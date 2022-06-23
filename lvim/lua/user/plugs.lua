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
    { 'navarasu/onedark.nvim' }, -- alternative onedark
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
    -- Color highlighter colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- mode = "background", -- Available modes: foreground, background
            })
        end,
    },
    -- ## Code runners
    {
        "CRAG666/code_runner.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("code_runner").setup({
                -- choose default mode (valid term, tab, float, toggle)
                mode = "term",
                filetype = {
                    python = "python3 -u",
                    sh = "bash",
                    typescript = "deno run",
                    java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
                    csharp = "cd $dir && mcs $fileName && mono $fileNameWithoutExt.exe",
                    rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
                },
            })
            vim.api.nvim_set_keymap("n", "<F10>", "<CMD>RunCode<CR>", { silent = false })
        end
    },
    -- Sniprun
    -- Runs part of code, Requires rust toolchain and cargo.
    -- {
    --     "michaelb/sniprun",
    --     run = "bash ./install.sh",
    --     config = function()
    --         require("sniprun").setup({
    --             selected_interpreters = { "Python3_original", "Lua_nvim" },
    --             repl_enable = { "Python3_original" },
    --             -- display = { "TerminalWithCode" },
    --             -- display = { "Classic", "VirtualTextOK", "NvimNotify" },
    --             display = {
    --                 "VirtualTextOk",
    --                 "VirtualTextErr",
    --                 "TempFloatingWindow"
    --             },
    --         })
    --     end
    -- },
    -- ## Treesitter
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { "p00f/nvim-ts-rainbow" },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "nvim-treesitter/playground",
        event = "BufRead",
    },
}
