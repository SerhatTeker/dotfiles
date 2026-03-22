M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    -- flash toggle
    { "<c-s>", false },
    -- assign something else later?
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return M
