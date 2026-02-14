return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim", version = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
    },
    ft = "python", -- Load when opening Python files
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
    },
    opts = { -- this can be an empty lua table - just showing below for clarity.
        search = {}, -- if you add your own searches, they go here.
        options = {} -- if you add plugin options, they go here.
    },
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("illuminate").configure({
        delay = 200,
        under_cursor = true,
        filetypes_denylist = {
          "NvimTree",
          "TelescopePrompt",
          "alpha",
          "dashboard",
        },
      })
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
      "sindrets/diffview.nvim",
      event = "BufRead",
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/session/"),
      branch_separator = "@@", -- string used to separate session directory name from branch name
      autosave = true,         -- automatically save session files when exiting Neovim
      autoload = true,         -- automatically load the session for the cwd on Neovim startup
      use_git_branch = true,  -- to have multiple session files for a given project branches
    },
    init = function()
      -- Set this here so it's ready before the plugin starts
      vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
    end,
    config = function(_, opts)
      local persisted = require("persisted")
      local utils = require("persisted.utils")
      local ignored_branches = {
        "main",
      }

      persisted.setup(opts)

      -- Only start the plugin if the branch isn't in the ignored list
      if not utils.in_table(persisted.branch(), ignored_branches) then
        persisted.start()
      end
    end
  }

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
