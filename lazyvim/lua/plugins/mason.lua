M = {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "flake8",
        -- "ruff",
        "prettier",
        "shfmt",
        "shellcheck",
        "codespell",
      },
    },
  },
}

return M
