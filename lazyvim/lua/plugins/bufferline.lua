M = {
  {
    "akinsho/bufferline.nvim",
    -- LazyVim will deep merge this `opts` table with its own default `opts`
    opts = {
      options = {
        always_show_bufferline = true,
        diagnostics = false,
        buffer_close_icon = "",
        close_icon = "",
        indicator = {
          style = "icon",
          icon = "",
        },
      },
      highlights = {
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
        },
      },
    },
  },
}

return M
