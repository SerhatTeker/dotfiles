return {
  {
    "L3MON4D3/LuaSnip",
    opts = function()
      require("luasnip").env_namespace("SYS", {
        vars = {
          WDAYNUM = function()
            return vim.fn.trim(vim.fn.system("wday"))
          end,
        },
      })
    end,
  },
}
