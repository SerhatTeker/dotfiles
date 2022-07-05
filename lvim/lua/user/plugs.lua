-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.notify.active = true
lvim.builtin.dap.active = true -- (default: false)
lvim.builtin.terminal.active = true
lvim.builtin.terminal.open_mapping = [[<c-e>]]

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
    return string.format('require("user.plugins.%s")', name)
end

local function default_config(name)
    return string.format('require("%s").setup()', name)
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
        config = default_config("nvim-ts-autotag"),
    },
    {
        "nvim-treesitter/playground",
        event = "BufRead",
    },

    -- ## DAP
    { "rcarriga/nvim-dap-ui",
        config = default_config("dapui"),
        requires = { "mfussenegger/nvim-dap" },

    },
    { "theHamsta/nvim-dap-virtual-text",
        config = default_config("nvim-dap-virtual-text"),
        requires = { "mfussenegger/nvim-dap" },
    },
    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    -- Persistence
    {
        "olimorris/persisted.nvim",
        -- event = "BufReadPre", -- this will only start session saving when an actual file was opened
        -- module = "persistence",
        config = function()
            local persisted = require("persisted")
            persisted.setup({
                save_dir = vim.fn.expand(vim.fn.stdpath "cache" .. "/session/"),
                -- options = { "buffers", "curdir", "tabpages", "winsize" },
                autosave = true,
                autoload = true,
            })
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
        config = default_config("Navigator"),
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
        config = default_config("todo-comments"),
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
        config = default_config("trim"),
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
            local blankline = require("indent_blankline")
            blankline.setup({
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
        "ray-x/go.nvim",
        config = get_config("golang"),
        -- run = ":GoInstallBinaries",
        ft = { "go" },
    },
    -- Search and replace
    {
        "nvim-pack/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
            local _map = vim.api.nvim_set_keymap
            local _opts = { silent = true, noremap = true }
            -- _map("n", "<C-s>", [[<CMD>lua require('spectre').open()<CR>]], _opts)
            -- search current word
            _map("n", "<C-s>", [[<Cmd>lua require('spectre').open_visual({select_word=true})<CR>]], _opts)
        end,
    },
}
