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

-- ## Plugins {{{

lvim.plugins = {
    -- # Core
    -- ## Treesitter
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
        commit = "f5f13206ec33e55b16c8e1a9dec301e8bead4835",
    },
    -- { "p00f/nvim-ts-rainbow" },
    { "HiPhish/nvim-ts-rainbow2" },
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
                autosave = true, -- automatically save session files when exiting Neovim
                autoload = true, -- automatically load the session for the cwd on Neovim startup
            })
            vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
        end,
    },
    -- ## Lastplace
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
        config = default_config("Navigator"),
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
        config = function()
            require("todo-comments").setup({
                keywords = {
                    -- # Defaults
                    -- TODO = { icon = " ", color = "info" },
                    -- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    -- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    -- NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    -- # Custom
                    HACK = { icon = " ", color = "warning", alt = { "DEBUG" } },
                    TEST = { icon = " ", color = "warning",
                        alt = { "TESTING", "PASSED", "FAILED" }
                    },
                },
            })
        end
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
    {
        "jakewvincent/mkdnflow.nvim",
        config = default_config("mkdnflow"),
        ft = { "markdown" },
    },
    -- ### Markdown Preview
    {
        "ellisonleao/glow.nvim",
        config = default_config("glow"),
        ft = { "markdown" },
    },
    -- # Additional
    -- ## Colorschemes
    { "Mofiqul/vscode.nvim" },
    { "ellisonleao/gruvbox.nvim" }, -- alternative gruvbox
    { "sainnhe/gruvbox-material" },
    { 'navarasu/onedark.nvim' }, -- alternative onedark
    { "SerhatTeker/neodarker.nvim" },
    -- ## Harpoon
    { "ThePrimeagen/harpoon" },
    -- ## Trim
    {
        "SerhatTeker/trim.nvim",
        event = "BufWritePre",
        config = default_config("trim"),
    },
    -- ## Shade, dim InactiveWindow
    -- INFO: Disabled, not working with sessions
    -- https://github.com/sunjon/Shade.nvim/issues/2
    -- { "sunjon/shade.nvim" },
    -- ## SymbolsOutline
    {
        "simrat39/symbols-outline.nvim",
        config = default_config("symbols-outline"),
    },
    -- ## Color highlighter colorizer
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- Attach to certain Filetypes, add special configuration for `html`
            -- Use `background` for everything else.
            require('colorizer').setup({
                'css';
                'scss';
                'javascript';
                html = {
                    mode = 'foreground';
                },
            })

        end,
    },
    -- ## Code runner
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
    {
        "gpanders/editorconfig.nvim",
    },
    -- ## Zen Mode
    {
        "folke/zen-mode.nvim",
        config = default_config("zen-mode"),
    },
    -- ## Activity tracking
    -- ActivityWatch watcher: https://docs.activitywatch.net/en/latest/watchers.html
    {
        "ActivityWatch/aw-watcher-vim",
        cond = function()
            return vim.fn.filereadable(os.getenv("HOME") .. "/apps/activitywatch/aw-qt") ~= 0
        end

    },
    -- ## Leap, fast motions
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()
            -- Verbose mapping to overwrite default lvim which-key
            vim.keymap.set("n", "s", "<Plug>(leap-forward)", { remap = false })
        end,
    },
    {
        "jamestthompson3/nvim-remote-containers",
        -- config = default_config("zen-mode"),
    }
}
-- }}}
-- }}}
