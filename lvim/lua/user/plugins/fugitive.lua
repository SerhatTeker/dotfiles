local opts = { noremap = true, silent = true }

-- Status
vim.api.nvim_set_keymap("n", "ss", "<cmd>G<cr>", opts)
-- Do commit
vim.api.nvim_set_keymap("n", "cc", "<cmd>Git commit<cr>", opts)
-- Do push
vim.api.nvim_set_keymap("n", "<leader>gp", "<cmd>Git push<cr>", opts)
-- Do pull
vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>Git pull<cr>", opts)

-- Resolve merge conflicts
vim.api.nvim_set_keymap("n", "<leader>mc", "<cmd>Gdiffsplit!<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>gm", "<cmd>Gdiffsplit!<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>m2", "<cmd>diffget //2<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>m3", "<cmd>diffget //3<cr>", opts)

-- Git diff previous vs the current version
-- With <!> left to right, and focus on current
-- TIP: Therefore close with <C-W><C-O>, not :diffoff
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>Gdiffsplit!<cr>", opts)

-- Show History
vim.api.nvim_set_keymap("n", "<leader>HH", "<cmd>Gclog<cr>", opts)
-- Show File History
vim.api.nvim_set_keymap("n", "<leader>HF", "<cmd>0Gclog!<cr>", opts)

-- Custom Commands {{{

-- Amend aliases
vim.api.nvim_create_user_command("GCN", "Git commit -v --no-edit --amend", { force = true })
vim.api.nvim_create_user_command("GCAN", "Git commit -v -a --no-edit --amend", { force = true })
vim.api.nvim_create_user_command("GCE", "Git commit --amend --edit", { force = true })

-- Alias for old habit
vim.api.nvim_create_user_command("GP", "Git push", { force = true })

-- Push set upstream
vim.api.nvim_create_user_command("GPSUP",
    ":!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD 2>/dev/null)", { force = true })
-- }}}
