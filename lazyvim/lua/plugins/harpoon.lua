M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,

      desc = "Harpoon Add File",
    },
    {
      "<leader>p",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon Quick Menu",
    },
  },
}

return M
