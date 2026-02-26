-- Shortcuts for qa
vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Git
vim.api.nvim_create_user_command("DiffviewUpstream", "DiffviewOpen upstream/master...HEAD", { force = true })
