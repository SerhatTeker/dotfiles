M = {
  -- 1. Disable neo-tree, which is LazyVim's default explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  -- 2. Install and configure nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      -- Global keymap to toggle NvimTree
      { "<C-t>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- default mappings
        api.map.on_attach.default(bufnr)

        -- Add your custom mappings
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "<C-t>", api.tree.toggle, opts("Toggle"))
      end

      -- Call the setup function with your translated options
      require("nvim-tree").setup({
        on_attach = on_attach,
        update_focused_file = {
          enable = true,
          update_root = {
            enable = false,
          },
        },
        view = {
          side = "left",
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
        diagnostics = {
          enable = false,
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
        filters = {
          git_ignored = false, -- I (Shift + I) to toggle
          custom = {
            ".mypy_cache",
            "__pycache__",
            ".pytest_cache",
            "htmlcov",
            "hypothesis",
            "node_modules",
            "\\.cache",
          },
        },
      })
    end,
  },
}

return M
