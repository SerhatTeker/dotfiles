M = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- completely disables the inline error/warning text
        virtual_text = false,

        -- Keeps the signs (icons) in the far left gutter
        signs = true,

        -- Keeps underlines on the code with the error
        underline = true,
      },
    },
  },
}

return M
