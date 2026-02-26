M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = function()
    local keys = {
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
    }

    -- disable default 1..9 keys
    for i = 1, 9 do
      table.insert(keys, { "<leader>" .. i, false })
    end
    return keys
  end,
}

return M
