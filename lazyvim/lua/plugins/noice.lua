-- Show history
-- :Telescope noice or :Noice history
M = {
  {
    "folke/noice.nvim",
    -- enabled = false, -- to completely disable
    opts = {
      cmdline = {
        -- Changes the command line from a floating popup back to the classic bottom bar
        view = "cmdline",
      },
    },
  },
}

return M
