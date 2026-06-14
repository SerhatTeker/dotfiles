return {
  "saghen/blink.cmp",
  opts = {
    -- Keymap: "enter" preset makes <CR> accept when menu is open, else newline.
    -- Tab/S-Tab are overridden with an ordered chain: each command runs only
    -- if its precondition holds, so one key serves two contexts:
    --   1. menu open      -> select_next / select_prev
    --   2. snippet active -> snippet_forward / snippet_backward
    --   3. otherwise      -> fallback (literal <Tab>)
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      ghost_text = { enabled = false },
    },
  },
}
