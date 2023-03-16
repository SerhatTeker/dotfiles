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
    -- InlayHints
    lsp_inlay_hints = {
        enable = false,
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = " ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
    },
})

-- Run gofmt + goimport on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :lua require('go.format').goimport() ]], false)
