M = {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = {
        python = { "flake8", "codespell" },
        javascript = { "codespell" },
        sh = { "shellcheck" },
      }

      -- Override default arguments to inject custom settings
      opts.linters = {
        flake8 = {
          args = {
            "--max-line-length",
            "120",
            "--format=%(path)s:%(row)d:%(col)d: %(code)s %(text)s",
            "--no-show-source",
            "-",
          },
        },
        shellcheck = {
          args = {
            "--severity",
            "warning",
            "--format",
            "json",
            "-",
          },
        },
      }
    end,
  },
}

return M
