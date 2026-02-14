nnoremap <leader>a <CMD>lua require("harpoon.mark").add_file()<CR>              " add file to harpoon"
nnoremap <leader>p <CMD>lua require("harpoon.ui").toggle_quick_menu()<CR>       " view all project marks
nnoremap <leader>N <CMD>lua require("harpoon.ui").nav_next()<CR>                " navigates to previous mark
nnoremap <leader>M <CMD>lua require("harpoon.ui").nav_prev()<CR>                " navigates to next mark
