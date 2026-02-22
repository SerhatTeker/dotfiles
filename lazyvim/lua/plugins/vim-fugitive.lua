-- vim-fugitive

-- https://www.lazyvim.org/configuration/plugins
-- Make sure to use the exact same mode as the keymap you want to disable.
-- You don't have to specify a mode for normal mode keymaps.
-- return {
--   "folke/flash.nvim",
--   keys = {
--     -- disable the default flash keymap
--     { "s", mode = { "n", "x", "o" }, false },
--   },
-- }

-- local silence_opts = { silent = true, noremap = true }

M = {
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
      "Gedit",
    },
    ft = { "fugitive" },
    keys = {
      { "ss", "<cmd>G<cr>", desc = "Git status" },
      { "cc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Git pull" },
    },
  },
}

return M
