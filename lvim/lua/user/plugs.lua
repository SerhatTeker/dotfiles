-- Core {{{

-- NOTE: After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- # Dap
lvim.builtin.dap.active = true -- (default: false)

-- # Terminal
lvim.builtin.terminal.active = true
-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.terminal.open_mapping = [[<c-\>]]
-- lvim.builtin.terminal.open_mapping = [[<leader>e]]

-- # Project
-- Disable project plugin since it messes nvim-tree setup.update_cwd
-- https://github.com/LunarVim/LunarVim/blob/48320e5f882a911707c56baf3865f663acb39f08/lua/lvim/core/nvimtree.lua#L168-L173
lvim.builtin.project.active = false

-- # Alpha
-- Using persisted instead
lvim.builtin.alpha.active = false

-- # Illuminate
lvim.builtin.illuminate.active = true -- verbose

-- # Breadcrumbs
lvim.builtin.breadcrumbs.active = false
-- }}}

-- # Additional Plugins {{{

-- ## Helper functions {{{

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
    return string.format('require("user.plugins.%s")', name)
end

-- Setup with default plugin configs
local function default_config(name)
    return string.format('require("%s").setup()', name)
end
-- }}}

local os_home = vim.fn.expand("$HOME")

-- ## Plugins {{{

lvim.plugins = {
    -- # Core
    -- { "p00f/nvim-ts-rainbow" },
    { "HiPhish/nvim-ts-rainbow2" },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = default_config("nvim-ts-autotag"),
    },
    -- ## Treesitter
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    -- {
    --     "nvim-treesitter/playground",
    --     event = "BufRead",
    -- },
    -- -- ## DAP
    -- {
    --     "rcarriga/nvim-dap-ui",
    --     config = default_config("dapui"),
    --     requires = { "mfussenegger/nvim-dap" },
    -- },
    -- {
    --     "theHamsta/nvim-dap-virtual-text",
    --     config = default_config("nvim-dap-virtual-text"),
    --     requires = { "mfussenegger/nvim-dap" },
    -- },
    --
    -- ## Trouble
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",

    },
    -- ## Persistence
    {
        "olimorris/persisted.nvim",
        -- event = "BufReadPre", -- this will only start session saving when an actual file was opened
        -- module = "persistence",
        config = function()
            require("persisted").setup({
                save_dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/session/"),
                branch_separator = "@@", -- string used to separate session directory name from branch name
                autosave = true,         -- automatically save session files when exiting Neovim
                autoload = true,         -- automatically load the session for the cwd on Neovim startup
            })
            vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
        end,
    },
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
    { "tpope/vim-repeat" },
    {
        "kylechui/nvim-surround",
        config = default_config("nvim-surround"),
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
    -- # Languages
    -- ## Golang
    {
        "ray-x/go.nvim",
        config = get_config("golang"),
        -- run = ":GoInstallBinaries",
        ft = { "go" },
    },
    -- ## Markdown
    -- ### Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = "markdown",
        cmd = { "MarkdownPreview" },
    },
    -- # Additional
    --
    -- ## Colorschemes
    { "SerhatTeker/neodarker.nvim" },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- change_background()
            require("gruvbox").setup({
                contrast = "hard"
            })
            -- vim.cmd([[colorscheme gruvbox]])
        end,
    },
    { 'navarasu/onedark.nvim' }, -- alternative onedark
    { "Mofiqul/vscode.nvim" },
    -- ## Harpoon
    { "ThePrimeagen/harpoon" },
    -- ## Trim
    {
        "cappyzawa/trim.nvim",
        event = "BufWritePre",
        config = function()
            require("trim").setup({
                disable = { "markdown" },
                -- trim_last_line = false,
            })
        end,
    },
    -- ## Shade, dim InactiveWindow
    -- INFO: Disabled, not working with sessions
    -- https://github.com/sunjon/Shade.nvim/issues/2
    -- { "sunjon/shade.nvim" },
    -- ## SymbolsOutline
    {
        "simrat39/symbols-outline.nvim",
        config = default_config("symbols-outline"),
        -- https://github.com/simrat39/symbols-outline.nvim?tab=readme-ov-file#default-keymaps
    },
    -- ## Color highlighter colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- Attach to certain Filetypes, add special configuration for `html`
            -- Use `background` for everything else.
            require('colorizer').setup({
                'css',
                'scss',
                'javascript',
                html = {
                    mode = 'foreground',
                },
            })
        end,
    },
    { "mfussenegger/nvim-dap-python" },
    { "nvim-neotest/neotest" },
    { "nvim-neotest/neotest-python" },
    -- ## Search and replace
    {
        "nvim-pack/nvim-spectre",
        event = "BufRead",
        config = function()
            require("spectre").setup()
            local map = vim.api.nvim_set_keymap
            local opts = { silent = true, noremap = true, desc = "Search word under cursor" }
            -- _map("n", "<C-s>", [[<CMD>lua require('spectre').open()<CR>]], _opts)
            -- search current word
            map("n", "<C-s>",
                [[<Cmd>lua require('spectre').open_visual({select_word=true})<CR>]],
                opts
            )
        end,
    },
    -- ## Editorconfig
    { "gpanders/editorconfig.nvim" },
    -- ## Zen Mode
    {
        "folke/zen-mode.nvim",
        config = default_config("zen-mode"),
    },
    -- -- ## Activity tracking
    -- -- ActivityWatch watcher: https://docs.activitywatch.net/en/latest/watchers.html
    -- {
    --     "ActivityWatch/aw-watcher-vim",
    --     cond = function()
    --         return vim.fn.filereadable(os.getenv("HOME") .. "/apps/activitywatch/aw-qt") ~= 0
    --     end

    -- },
    -- ## Navigation
    -- ### Leap, fast motions
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
            -- Verbose mapping to overwrite default lvim which-key
            vim.keymap.set("n", "s", "<Plug>(leap-forward)", { remap = false })
        end,
    },
    -- ### Navigate between neovim and terminal multiplexer
    {
        'numToStr/Navigator.nvim',
        config = default_config("Navigator"),
    },
    -- -- ### Navigator
    -- -- Code analysis & navigation. Exploring LSP and Treesitter symbols.
    -- -- keymaps: https://github.com/ray-x/navigator.lua?tab=readme-ov-file#default-keymaps
    -- {
    --     "ray-x/navigator.lua",
    --     config = get_config("navigation"),
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --         {
    --             "ray-x/guihua.lua",
    --             build = "cd lua/fzy && make",
    --         },
    --     },
    -- },
    --- ### Tekescope Live Grep Arg Modif
    {
        "nvim-telescope/telescope-live-grep-args.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    -- -- ### Lastplace
    -- {
    --     "ethanholz/nvim-lastplace",
    --     event = "BufRead",
    --     config = function()
    --         require("nvim-lastplace").setup({
    --             lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    --             lastplace_ignore_filetype = {
    --                 "gitcommit", "gitrebase", "svn", "hgcommit",
    --             },
    --             lastplace_open_folds = true,
    --         })
    --     end,
    -- },
    -- ### Obsidian
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        -- ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
            "BufReadPre " .. vim.fn.expand("$OBSIDIAN") .. "/**.md",
            "BufNewFile " .. vim.fn.expand("$OBSIDIAN") .. "/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "main",
                    path = os.getenv("OBSIDIAN"),
                },
            },
            notes_subdir = "imbox",
            new_notes_location = "notes_subdir",
            disable_frontmatter = true,
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M:%S",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {
                    date_iso = function()
                        return os.date("%Y-%m-%dT%H:%M:%S%z", os.time())
                    end,
                },
            },
            -- key mappings, below are the defaults
            mappings = {
                -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
            },
            completion = {
                nvim_cmp = true,
                min_chars = 2,
            },
            -- Optional, determines how certain commands open notes. The valid options are:
            -- 1. "current" (the default) - to always open in the current window
            -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
            -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
            open_notes_in = "current",
        },
    },
    -- ## AI
    -- ### Github Copilot
    -- {
    --     "github/copilot.vim",
    --     config = get_config("copilot"),
    -- },
    -- ### ChatGPT API
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        -- config = get_config("openai-chatgpt"),  -- doesn't work for custom actions
        config = function()
            -- https://platform.openai.com/docs/models/gpt-4-and-gpt-4-turbo
            local gpt_35 = "gpt-3.5-turbo"
            local gpt_4 = "gpt-4"
            local gpt_4_turbo = "gpt-4-1106-preview"
            local use_model = gpt_4_turbo

            require("chatgpt").setup({
                -- using $OPENAI_API_KEY env var

                -- Additional custom actions
                -- https://github.com/jackMort/ChatGPT.nvim/issues/168
                actions_paths = { os_home .. "/dotfiles/lvim/openai/custom-actions.json" },

                openai_params = {
                    -- model = "gpt-3.5-turbo",
                    model = use_model,
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 3000,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
                openai_edit_params = {
                    model = use_model,
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    temperature = 0,
                    top_p = 1,
                    n = 1,
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
}
-- }}}
-- }}}
