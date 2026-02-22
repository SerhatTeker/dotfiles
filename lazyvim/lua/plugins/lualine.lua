M = {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- 1. Override the separators for the pipe-like look
      opts.options = opts.options or {}
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "|", right = "|" }

      -- 2. Define your custom mode component from LunarVim
      local mode = {
        function()
          return " "
        end,
        padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
      }

      -- 3. Override the LazyVim default sections
      opts.sections = {
        lualine_a = {
          mode,
        },
        lualine_b = {
          { "branch", icon = "" },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1, -- 1: Relative path
            shorting_target = 40,
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          "diagnostics",
          "filetype",
          "fileformat",
          "encoding",
        },
        lualine_y = {},
        lualine_z = { "location" },
      }

      opts.extensions = { "nvim-tree", "lazy" }

      return opts
    end,
  },
}

-- return {}
return M
