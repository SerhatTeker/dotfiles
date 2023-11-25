-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.g.copilot_filetypes = {
    ["*"] = false,
    ["go"] = true,
    ["python"] = true,
    ["lua"] = true,
    ["rust"] = true,
    ["c"] = true,
    ["javascript"] = true,
    ["typescript"] = true,
}

vim.cmd[[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]
