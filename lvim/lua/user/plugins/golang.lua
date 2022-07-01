require("go").setup({
    -- lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt

    goimport = "gopls", -- if set to "gopls" will use golsp format
    gofmt = "gopls", -- if set to gopls will use golsp format
    max_line_len = 120,
    tag_transform = false,
    test_dir = "",
    comment_placeholder = "   ",
    lsp_cfg = true, -- false: use your own lspconfig
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = true, -- use on_attach from go.nvim
    lsp_codelens = false, -- set to false to disable codelens, true by default
    dap_debug = true,
    -- icons
    icons = false,
    -- lsp_diag_virtual_text = { space = 0, prefix = "" },
    lsp_diag_virtual_text = false,
})

-- Run gofmt + goimport on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :lua require('go.format').goimport() ]], false)
