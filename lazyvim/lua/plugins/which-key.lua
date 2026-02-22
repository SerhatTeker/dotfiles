M = {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local wk = require("which-key")
      wk.add({
        -- Diffview
        -- { "<leader>v", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
        { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open", mode = "n" },
      })
    end,
  },
}

return M
