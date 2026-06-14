-- ###########################################################################
-- Python DAP: generic setup + keymap overrides
-- ###########################################################################
-- Project-specific attach configs (pathMappings, names) live in config/private.lua.
--
-- Debug flow
--   1. terminal (in the project): start the debug target (runs debugpy on a port)
--   2. nvim:    <leader>db  set breakpoint
--   3.          <leader>dc  pick the attach config registered in private.lua
--   4. step/inspect:  see cheat sheet below
--   5. end:     <leader>dd  disconnect  |  <leader>dx  hard close  |  :DapStatus
--   Breakpoints persist across sessions.

-- ###########################################################################
-- pdb ↔ DAP cheat sheet
-- ###########################################################################
--   n  (next)        -> <leader>do   step over  (lowercase o, remapped)
--   s  (step)        -> <leader>di   step into
--   r  (return)      -> <leader>dO   step out   (capital O, remapped)
--   c  (continue)    -> <leader>dc
--   p <expr>         -> <leader>de   eval (normal + visual)
--   pp / interact    -> <leader>dr   toggle REPL
--   w  (where)       -> <leader>ds   session / stack in dap-ui
--   u / d (frame)    -> <leader>dk / <leader>dj
--   b  (break)       -> <leader>db
--   q  (quit)        -> <leader>dd   disconnect (attach-safe)
--   -                -> <leader>dx   hard close session + UI
--   -                -> <leader>du   toggle dap-ui panels
M = {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect (attach)" },
      { "<leader>dx", function() require("dap").close(); require("dapui").close() end, desc = "Close session + UI" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end,  desc = "Step Out" },
    },
    opts = function()
      local dap = require("dap")

      vim.api.nvim_create_user_command("DapDisconnect", function() dap.disconnect() end, { desc = "DAP: disconnect from attach session" })
      vim.api.nvim_create_user_command("DapClose", function()
        dap.close()
        require("dapui").close()
      end, { desc = "DAP: close session + UI" })
      vim.api.nvim_create_user_command("DapStatus", function()
        local s = dap.session()
        vim.notify(s and ("active: " .. (s.config and s.config.name or "?")) or "no session", vim.log.levels.INFO)
      end, { desc = "DAP: show session status" })
    end,
  },
}

return M
