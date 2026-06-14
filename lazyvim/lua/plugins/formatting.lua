M = {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "120" },
        },
      },
    },
  },
}
return M
