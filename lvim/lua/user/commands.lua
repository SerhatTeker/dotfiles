-- Shortcuts for qa {{{

vim.api.nvim_create_user_command("Q", "qa", { force = true })
vim.api.nvim_create_user_command("WQ", "wqa", { force = true })
-- }}}

-- Buffers
vim.api.nvim_create_user_command("BufCurOnly", "%bdelete|edit#|bdelete#", { force = true })

-- Snapshot {{{

local function sort_snapshot(path, file)
    if vim.fn.filereadable(file) == 1 then
        local tmp = join_paths(path, "temp_default.json")
        local cmd = "jq --sort-keys . " .. file .. " > " .. tmp
        os.execute(cmd)
        os.rename(tmp, file)
    else
        vim.notify("Snapshot file not found!", vim.log.levels.ERROR, { title = "sort_snapshot()" })
    end
end

local function replace_snapshot()
    local snapshot_path = join_paths(get_cache_dir(), "snapshots")
    local snapshot_name = "default.json"
    local snapshot_file = join_paths(snapshot_path, snapshot_name)
    local sp = snapshot_file

    local function call_proc(process, opts, cb)
        local output, error_output = "", ""
        local handle_stdout = function(err, chunk)
            assert(not err, err)
            if chunk then
                output = output .. chunk
            end
        end

        local handle_stderr = function(err, chunk)
            assert(not err, err)
            if chunk then
                error_output = error_output .. chunk
            end
        end

        local uv = vim.loop
        local handle

        local stdout = uv.new_pipe(false)
        local stderr = uv.new_pipe(false)

        local stdio = { nil, stdout, stderr }

        handle = uv.spawn(
            process,
            { args = opts.args, cwd = opts.cwd or uv.cwd(), stdio = stdio },
            vim.schedule_wrap(function(code)
                if code ~= 0 then
                    stdout:read_stop()
                    stderr:read_stop()
                end

                local check = uv.new_check()
                check:start(function()
                    for _, pipe in ipairs(stdio) do
                        if pipe and not pipe:is_closing() then
                            return
                        end
                    end
                    check:stop()
                    handle:close()
                    cb(code, output, error_output)
                end)
            end)
        )

        uv.read_start(stdout, handle_stdout)
        uv.read_start(stderr, handle_stderr)

        return handle
    end

    local plugins_list = {}

    local completed = 0

    local function write_lockfile()
        local default_plugins = {}
        local active_jobs = {}

        local core_plugins = _G.packer_plugins
        for plugin_name, data in pairs(core_plugins) do
            local name = plugin_name
            local url = data.url
            local commit = ""

            table.insert(default_plugins, {
                name = name,
                url = url,
                commit = commit,
            })
        end

        table.sort(default_plugins, function(a, b)
            return a.name < b.name
        end)

        for _, entry in pairs(default_plugins) do
            -- print(vim.inspect(index))
            -- print(vim.inspect(entry))

            local on_done = function(success, result, errors)
                completed = completed + 1
                if not success then
                    print("error: " .. errors)
                    return
                end
                local latest_sha = result:gsub("\tHEAD\n", ""):sub(1, 7)

                -- print("latest_sha: " .. latest_sha)

                plugins_list[entry.name] = {
                    commit = latest_sha,
                }
            end

            local handle = call_proc("git", { args = { "ls-remote", entry.url, "HEAD" } }, on_done)
            assert(handle)
            table.insert(active_jobs, handle)
        end

        local msg = "active: " .. #active_jobs .. "\n" .. "plugins: " .. #default_plugins
        vim.notify(msg, vim.log.levels.INFO, { title = "Snapshot snapshot" })

        vim.wait(#active_jobs * 60 * 1000, function()
            return completed == #active_jobs
        end)

        local fd = assert(io.open(sp, "w"))
        fd:write(vim.json.encode(plugins_list), "\n")
        fd:flush()
    end

    -- Delete and Create
    if vim.fn.filereadable(snapshot_file) == 1 then
        os.execute("rm -f " .. snapshot_file)
    end

    write_lockfile()
    sort_snapshot(snapshot_path, snapshot_file)
end

vim.api.nvim_create_user_command(
    "Snapshot",
    replace_snapshot,
    { nargs = 0 }
)
-- }}}
