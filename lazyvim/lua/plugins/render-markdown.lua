-- In-buffer markdown rendering: headings, code blocks, tables, callouts.
-- Needs the `markdown` + `markdown_inline` treesitter parsers, which LazyVim
-- already puts in `ensure_installed`, and a Nerd Font for the icons.
-- Rendering starts off; turn it on with <leader>um.
M = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  opts = {
    -- Off at startup: markdown files open as plain text. <leader>um renders them.
    enabled = false,
    -- Show the raw text again on the cursor line, so editing stays literal.
    anti_conceal = { enabled = true },
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
    },
    -- Off: needs the `latex` parser plus a `utftex`/`latex2text` binary,
    -- neither of which is installed. Leaving it on only adds health warnings.
    latex = { enabled = false },
    -- Completion source for callouts and checkboxes. blink.cmp is the
    -- LazyVim default engine, see plugins/blink.lua.
    completions = { blink = { enabled = true } },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    Snacks.toggle({
      name = "Render Markdown",
      get = require("render-markdown").get,
      set = require("render-markdown").set,
    }):map("<leader>um")
  end,
}

return M
