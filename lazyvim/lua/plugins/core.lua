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

-- local os_home = vim.fn.expand("$HOME")

M = {
  -- # Core
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = default_config("nvim-ts-autotag"),
  },
  -- ## Treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  -- },
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
  { "tpope/vim-repeat" },
  {
    "kylechui/nvim-surround",
    config = default_config("nvim-surround"),
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- # Languages
  -- ## Golang
  -- {
  --   "ray-x/go.nvim",
  --   config = get_config("golang"),
  --   -- run = ":GoInstallBinaries",
  --   ft = { "go" },
  -- },
  -- # Additional
  --
  -- ## Colorschemes
  { "SerhatTeker/neodarker.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- change_background()
      require("gruvbox").setup({
        contrast = "hard",
        -- invert_tabline = true,
        overrides = {
          TabLineSel = { fg = "#cc241d", bg = "#cc241d", reverse = false },
        },
      })
      -- vim.cmd([[colorscheme gruvbox]])
    end,
  },
  { "Mofiqul/vscode.nvim" },
  {
    "navarasu/onedark.nvim",
    -- priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
        colors = {
          -- Main Backgrounds - neodarker
          bg0 = "#1e222a", -- 'bg'
          -- bg0 = "#191b20"  -- black-ish
          -- bg0 = "#1b1f27", -- 'alt_bg'
          -- bg1 = "#282C34",
        },
      })
    end,
  },
  -- -- automatic dark mode
  -- -- requires: brew install cormacrelf/tap/dark-notify
  -- {
  --   "cormacrelf/dark-notify",
  --   commit = "dcc39f2d7bbff64b6c3a19b3094f588ff64b4578",
  --   config = function()
  --     require("dark_notify").run({
  --       -- -- Gruvbox
  --       schemes = {
  --         dark = "gruvbox",
  --         light = "gruvbox",
  --       },
  --       -- -- OneDark
  --       -- schemes = {
  --       --     dark  = "neodarker",
  --       --     light = "onedark",
  --       -- },
  --     })
  --   end,
  -- },
  -- ## Trim
  {
    "cappyzawa/trim.nvim",
    event = "BufWritePre",
    config = function()
      require("trim").setup({
        ft_blocklist = { "markdown" },
        -- trim_last_line = false,
      })
    end,
  },
  -- ## Shade, dim InactiveWindow
  -- INFO: Disabled, not working with sessions
  -- https://github.com/sunjon/Shade.nvim/issues/2
  -- { "sunjon/shade.nvim" },
  --
  -- ## Color highlighter colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      -- Attach to certain Filetypes, add special configuration for `html`
      -- Use `background` for everything else.
      require("colorizer").setup({
        "css",
        "scss",
        "javascript",
        html = {
          mode = "foreground",
        },
      })
    end,
  },
  { "mfussenegger/nvim-dap-python" },
  { "nvim-neotest/neotest" },
  { "nvim-neotest/neotest-python" },
  -- ## Search and replace
  -- TODO: Move to it's lua file
  -- {
  --   "nvim-pack/nvim-spectre",
  --   event = "BufRead",
  --   config = function()
  --     require("spectre").setup()
  --     local map = vim.api.nvim_set_keymap
  --     local opts = { silent = true, noremap = true, desc = "Search word under cursor" }
  --     -- _map("n", "<C-s>", [[<CMD>lua require('spectre').open()<CR>]], _opts)
  --     -- search current word
  --     map("n", "<C-s>", [[<Cmd>lua require('spectre').open_visual({select_word=true})<CR>]], opts)
  --   end,
  -- },
  -- ## Editorconfig
  { "gpanders/editorconfig.nvim" },
  -- ## Zen Mode
  {
    "folke/zen-mode.nvim",
    config = default_config("zen-mode"),
  },
  -- },
  -- ### Navigate between neovim and terminal multiplexer
  -- {
  --   "numToStr/Navigator.nvim",
  --   config = default_config("Navigator"),
  -- },
  --- ### Telescope Live Grep Arg Modif
  -- {
  --   "nvim-telescope/telescope-live-grep-args.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
-- }}}
-- }}}
--

return M
