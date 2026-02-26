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
      -- Resolve merge conflicts
      -- { "<leader>m2", "<cmd>diffget //2<cr>" },
      -- { "<leader>m3", "<cmd>diffget //3<cr>" },
      -- -- Git diff previous vs the current version
      -- -- With <!> left to right, and focus on current
      -- -- TIP: Therefore close with <C-W><C-O>, not :diffoff
      -- { "<leader>mc", "<cmd>Gdiffsplit!<cr>" },
    },
    config = function()
      vim.api.nvim_create_user_command("GP", "Git push", { force = true })
      vim.api.nvim_create_user_command("GL", "Git pull", { force = true })
      vim.api.nvim_create_user_command("GCN", "Git commit -v --no-edit --amend", { force = true })
      vim.api.nvim_create_user_command("GCAN", "Git commit -v -a --no-edit --amend", { force = true })
      vim.api.nvim_create_user_command("GCE", "Git commit --amend --edit", { force = true })
    end,
  },
}

return M
