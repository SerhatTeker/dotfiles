M = {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- completely disables the inline error/warning text
        virtual_text = false,
      },
    },
  },
}

return M
