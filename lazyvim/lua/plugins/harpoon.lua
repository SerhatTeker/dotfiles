local harpoon = require("harpoon")

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>a",
      function()
        harpoon:list():add()
      end,
    },
    {
      "<leader>p",
      function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
    },
  },
}
