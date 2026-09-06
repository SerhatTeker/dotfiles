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

-- Tracks the last "<mode>:<scheme>" applied, so the FocusGained re-probe can skip
-- a redundant (and visibly flickery) reload when neither mode nor scheme changed.
local applied_key

-- Per-mode colorscheme, chosen by the `theme` command (bin/theme), persisted in
-- ~/.local/state/theme/schemes as `light=gruvbox` / `dark=one`. Missing file or
-- key falls back to the built-in defaults: light -> gruvbox, dark -> one.
local function read_scheme(mode)
  local default = mode == "light" and "gruvbox" or "one"
  local state = vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state")
  local ok, lines = pcall(vim.fn.readfile, state .. "/theme/schemes")
  if not ok then
    return default
  end
  for _, line in ipairs(lines) do
    local key, val = line:match("^(%w+)=(%w+)$")
    if key == mode and (val == "one" or val == "gruvbox") then
      return val
    end
  end
  return default
end

-- onedark ("one" scheme). Resets vim.g.onedark_config so the dark bg0 override
-- doesn't leak into light mode (setup() merges with `force`, never removing keys).
local function apply_onedark(mode)
  vim.g.onedark_config = nil
  local opts = {
    style = mode == "dark" and "darker" or "light",
    -- Color `self`/`cls` like class names (yellow) instead of the
    -- default builtin-variable salmon. Covers treesitter + pyright LSP.
    highlights = {
      ["@variable.builtin.python"] = { fg = "$yellow" },
      ["@lsp.type.selfParameter.python"] = { fg = "$yellow" },
    },
  }
  if mode == "dark" then
    opts.colors = { bg0 = "#191b20" }
  end
  require("onedark").setup(opts)
  require("onedark").load()
end

-- gruvbox scheme. Owns its own setup (contrast hard) so it applies regardless of
-- plugin load order; honors vim.o.background for its light/dark variant.
local function apply_gruvbox(mode)
  vim.o.background = mode
  require("gruvbox").setup({ contrast = "hard" })
  require("gruvbox").load()
end

-- Single source of truth: apply the scheme chosen for `mode`. Used at startup and
-- by dark-notify's onchange callback.
local function apply_theme(mode)
  mode = mode or "dark"
  local scheme = read_scheme(mode)
  if scheme == "gruvbox" then
    apply_gruvbox(mode)
  else
    apply_onedark(mode)
  end
  applied_key = mode .. ":" .. scheme
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
  -- gruvbox: setup + load are owned by apply_gruvbox (helper above).
  { "ellisonleao/gruvbox.nvim" },
  { "Mofiqul/vscode.nvim" },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() apply_theme("dark") end,
  },
  -- automatic dark mode
  -- requires: brew install cormacrelf/tap/dark-notify
  {
    "cormacrelf/dark-notify",
    lazy = false,
    dependencies = { "navarasu/onedark.nvim" },
    config = function()
      require("dark_notify").run({ onchange = apply_theme })

      -- Re-probe mode + scheme and reload only when mode:scheme actually changed
      -- (reloading otherwise visibly dims highlights).
      local function refresh()
        local mode = vim.trim(vim.fn.system("dark-notify --exit"))
        if mode ~= "dark" and mode ~= "light" then
          return
        end
        if (mode .. ":" .. read_scheme(mode)) ~= applied_key then
          apply_theme(mode)
        end
      end

      -- SIGUSR1: the `theme` command signals running nvims so a scheme change
      -- applies instantly, without waiting for focus. (Mode flips also arrive via
      -- dark-notify's watcher; the guard in refresh() stops a double reload.)
      vim.api.nvim_create_autocmd("Signal", { pattern = "SIGUSR1", callback = refresh })

      -- Backstop: dark-notify's async watcher occasionally misses system change
      -- events, and a nvim started after the signal won't have received it.
      -- Re-probe on focus too.
      vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, { callback = refresh })
    end,
  },
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
