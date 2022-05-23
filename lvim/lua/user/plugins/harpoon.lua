local opts = { noremap = true, silent = true}
local kmap = vim.api.nvim_set_keymap

kmap("n", "<leader>a", "<CMD>lua require('harpoon.mark').add_file()<CR>", opts)
kmap("n", "<leader>p", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
