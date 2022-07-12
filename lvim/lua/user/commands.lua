-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Snapshot {{{

-- Replace snapshot, then sort with jq
local function replace_snapshot()
    local snapshot_path = join_paths(get_cache_dir(), "snapshots")
    local snapshot_file = "default.json"
    local snapshot = join_paths(snapshot_path, snapshot_file)

    -- Delete and Create
    if vim.fn.filereadable(snapshot) == 1 then
        require("packer.snapshot").delete(snapshot)
    end
    require("packer").snapshot(snapshot)

    -- Sort with jq
    if vim.fn.executable("jq") then
        local tmp = join_paths(snapshot_path, "temp_default.json")
        os.execute("jq --sort-keys . " .. snapshot .. " > " .. tmp)
        os.rename(tmp, snapshot)
    else
        vim.notify("`jq` not found", vim.log.levels.ERROR, { title = "Snapshot" })
    end
end

vim.api.nvim_create_user_command(
    "Snapshot",
    replace_snapshot,
    { nargs = 0 }
)
-- }}}
