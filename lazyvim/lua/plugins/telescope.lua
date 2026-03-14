M = {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope", -- this tells lazy.nvim to register the command immediately
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
    keys = {
      -- custom additions
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      {
        "<C-f>",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Live grep (with args)",
      },
      -- default live_grep
      -- { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      -- buffer
      { "<S-b>", "<cmd>Telescope buffers initial_mode=insert<cr>", desc = "Find buffers" },
      { "<S-f>", "<cmd>Telescope current_buffer_fuzzy_find initial_mode=insert<cr>", desc = "Fuzzy find in buffer" },
      -- git
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
      { "<leader>gx", "<cmd>Telescope git_bcommits<cr>", desc = "Git buffer commits" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")
      local lga_actions = require("telescope-live-grep-args.actions")

      -- Core Telescope behavior overrides
      -- Safely merge your custom mappings into the EXISTING defaults
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["?"] = action_layout.toggle_preview,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      })
      -- Extension-specific overrides
      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        live_grep_args = {
          auto_quoting = false, -- Required so we can manually manage quotes
          mappings = {
            -- * Search everything normally: Just type import
            -- * Search only in Python files: Type "import" -t py
            -- * Search only in pytest files: Type "import" -g "*test*.py"
            -- * Search exact word only: Type "import" -w
            -- INFO: Rather to use <C-i> since it's more powerful
            i = {
              ["<C-h>"] = lga_actions.quote_prompt(), -- wrap word into quotes
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }), -- wrap into quotes and add --iglob flag
            },
          },
        },
      })
    end,
  },
}

return M

-- {{{
-- default keys
-- return {
--     keys = {
--       {
--         "<leader>,",
--         "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
--         desc = "Switch Buffer",
--       },
--       { "<leader>/", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
--       { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--       { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
--       -- find
--       {
--         "<leader>fb",
--         "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
--         desc = "Buffers",
--       },
--       { "<leader>fB", "<cmd>Telescope buffers<cr>", desc = "Buffers (all)" },
--       { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
--       { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
--       { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
--       { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
--       { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
--       { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
--       -- git
--       { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
--       { "<leader>gl", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
--       { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
--       { "<leader>gS", "<cmd>Telescope git_stash<cr>", desc = "Git Stash" },
--       -- search
--       { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
--       { "<leader>s/", "<cmd>Telescope search_history<cr>", desc = "Search History" },
--       { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
--       { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Lines" },
--       { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
--       { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
--       { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
--       { "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer Diagnostics" },
--       { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
--       { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
--       { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
--       { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
--       { "<leader>sj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
--       { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
--       { "<leader>sl", "<cmd>Telescope loclist<cr>", desc = "Location List" },
--       { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
--       { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
--       { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
--       { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
--       { "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
--       { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
--       { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
--       { "<leader>sw", LazyVim.pick("grep_string"), mode = "x", desc = "Selection (Root Dir)" },
--       { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "x", desc = "Selection (cwd)" },
--       { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
--       {
--         "<leader>ss",
--         function()
--           require("telescope.builtin").lsp_document_symbols({
--             symbols = LazyVim.config.get_kind_filter(),
--           })
--         end,
--         desc = "Goto Symbol",
--       },
--       {
--         "<leader>sS",
--         function()
--           require("telescope.builtin").lsp_dynamic_workspace_symbols({
--             symbols = LazyVim.config.get_kind_filter(),
--           })
--         end,
--         desc = "Goto Symbol (Workspace)",
--       },
--     },
-- }
-- }}}
