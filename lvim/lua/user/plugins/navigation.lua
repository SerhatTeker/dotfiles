require("navigator").setup({
    lsp = {
        -- enable = false,

        on_attach = function(bufnr, client)
            require("navigator.lspclient.mapping").setup({ bufnr = bufnr, client = client })
        end,

        format_on_save = false, -- {true|false} set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)

        disable_lsp = "all",

        diagnostic_virtual_text = false, -- show virtual for diagnostic message
        display_diagnostic_qf = false,   -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it

        diagnostic = {
            underline = true,
            virtual_text = false,     -- show virtual for diagnostic message
            update_in_insert = false, -- update diagnostic message in insert mode
            float = {
                -- setup for floating windows style
                focusable = false,
                sytle = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        },
    },
})
