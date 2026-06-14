M = {
  "olimorris/persisted.nvim",
  lazy = false,
  opts = {
    save_dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/session/"),
    branch_separator = "@@", -- string used to separate session directory name from branch name
    autosave = true, -- automatically save session files when exiting Neovim
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    use_git_branch = true, -- to have multiple session files for a given project branches
  },
  init = function()
    -- Set this here so it's ready before the plugin starts
    vim.o.sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize"
  end,
  config = function(_, opts)
    local persisted = require("persisted")
    local utils = require("persisted.utils")
    local ignored_branches = {
      "main",
    }

    persisted.setup(opts)

    -- Only start the plugin if the branch isn't in the ignored list
    if not utils.in_table(persisted.branch(), ignored_branches) then
      persisted.start()
    end
  end,
}

return M
