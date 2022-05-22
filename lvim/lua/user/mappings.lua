-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- one key stroke less
-- lvim.keys.normal_mode[";"] = ":"
vim.keymap.set('n', ";", ":")

-- Shortcuts for qa
vim.api.nvim_create_user_command('Q', 'qa', { force = true })
vim.api.nvim_create_user_command('WQ', 'wqa', { force = true })


-- buffers
vim.api.nvim_create_user_command('BufCurOnly', '%bdelete|edit#|bdelete#', { force = true })

lvim.keys.normal_mode["<S-n>"] = ":bn<CR>"
lvim.keys.normal_mode["<S-m>"] = ":bp<CR>"
lvim.keys.normal_mode["<C-b>d"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<C-b>c"] = ":BufCurOnly<CR>"
-- lvim.keys.normal_mode["<C-b>c"] = ":BufferCloseAllButCurrent<CR>"
