-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
lvim.builtin.dap.active = true -- (default: false)

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
    return string.format('require("config/%s")', name)
end

-- Additional Plugins
lvim.plugins = {
    -- # Core
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
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                show_current_context = true,
                -- show_current_context_start = true,
                filetype_exclude = {
                    "lspinfo", "packer", "checkhealth", "help", "man", "",
                    "python", "go",
                }
            })
        end
    },
    {
        'ray-x/go.nvim',
        config = function()
            require('go').setup({
                -- lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt

                goimport = 'gopls', -- if set to 'gopls' will use golsp format
                gofmt = 'gopls', -- if set to gopls will use golsp format
                max_line_len = 120,
                tag_transform = false,
                test_dir = '',
                comment_placeholder = '   ',
                lsp_cfg = true, -- false: use your own lspconfig
                lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
                lsp_on_attach = true, -- use on_attach from go.nvim
                lsp_codelens = false, -- set to false to disable codelens, true by default
                dap_debug = true,
            })
            -- Run gofmt + goimport on save
            -- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
            vim.api.nvim_exec([[ autocmd BufWritePre *.go :lua require('go.format').goimport() ]], false)
        end,
        run = ":GoInstallBinaries",
        ft = { "go" },
    },
    -- { 'mfussenegger/nvim-dap' },
    { 'rcarriga/nvim-dap-ui',
        config = function()
            require("dapui").setup()
        end

    },
    { 'theHamsta/nvim-dap-virtual-text',

        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    },
}
