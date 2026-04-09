local plugins = {}

local function load_plugin(name)
	local P = plugins[name]

	if not P then
		vim.notify('Plugin ' .. name .. ' does not exist', vim.log.levels.ERROR)
		return
	end

	if P.is_loaded then
		return
	end

	if P.is_loading then
		vim.notify('Circular deps in ' .. name, vim.log.levels.ERROR)
		return
	end

	P.is_loading = true

	if P.deps then
		for _, plugin in ipairs(P.deps) do
			load_plugin(plugin)
		end
	end

	if not P.is_local then
		vim.pack.add {
			{
				src = 'https://github.com/' .. P.src,
				version = P.version,
			},
		}
	end

	if not P.skip_require then
		P.package = require(name)
	end

	if P.user_load then
		P.user_load(P.package)
	else
		P.package.setup(P.user_opts)
	end

	P.is_loaded = true
end

---@param opts {
---	   [1]: string,
---	   enabled?: boolean,
---	   dir?: string,
---	   name?: string,
---	   opts?: {},
---	   deps?: string[],
---	   load?: fun(plugin: {}),
---	   is_theme?: boolean,
---	   skip_require?: boolean,
---	   cmds?: string[],
---	   keys?: {}[],
---	   ft?: string[],
---	   event?: string,
---}
__.add_plugin = function(opts)
	if opts.enabled == false then
		return
	end

	local src = opts[1]
	local name = opts.dir or opts.name or src:match('/([%w_.-]+)$'):gsub('.nvim$', ''):gsub('^nvim%-', '')

	if plugins[name] then
		vim.notify('Plugin duplicated ' .. name, vim.log.levels.ERROR)
	end

	local plugin = {
		is_instant = true,
		deps = opts.deps,
		user_opts = opts.opts,
		src = src,
		is_local = opts.dir ~= nil,
		user_load = opts.load,
		skip_require = opts.skip_require,
	}

	plugins[name] = plugin

	if opts.is_theme then
		plugin.is_instant = false

		load_plugin(name)
	end

	if opts.cmds then
		plugin.is_instant = false

		for _, cmd in ipairs(opts.cmds) do
			vim.api.nvim_create_user_command(cmd, function(event)
				local command = {
					cmd = cmd,
					bang = event.bang or nil,
					mods = event.smods,
					args = event.fargs,
					count = event.count >= 0 and event.range == 0 and event.count or nil,
				}

				if event.range == 1 then
					command.range = { event.line1 }
				elseif event.range == 2 then
					command.range = { event.line1, event.line2 }
				end

				load_plugin(name)

				local info = vim.api.nvim_get_commands({})[cmd] or vim.api.nvim_buf_get_commands(0, {})[cmd]
				if not info then
					vim.schedule(function()
						vim.print('Command ' .. cmd .. ' not found after loading ' .. name)
					end)

					return
				end

				command.nargs = info.nargs

				if event.args and event.args ~= '' and info.nargs and info.nargs:find '[1?]' then
					command.args = { event.args }
				end

				vim.cmd(command)
			end, {
				bang = true,
				range = true,
				nargs = '*',
				complete = function(_, line)
					vim.api.nvim_del_user_command(cmd)
					-- NOTE: return the newly loaded command completion
					return vim.fn.getcompletion(line, 'cmdline')
				end,
			})
		end
	end

	if opts.event then
		plugin.is_instant = false

		vim.api.nvim_create_autocmd(opts.event, {
			once = true,
			callback = function()
				load_plugin(name)
			end,
		})
	end

	if opts.ft then
		plugin.is_instant = false

		vim.api.nvim_create_autocmd({ 'FileType' }, {
			pattern = opts.ft,
			once = true,
			callback = function()
				load_plugin(name)
			end,
		})
	end

	if opts.keys then
		plugin.is_instant = false

		for _, map in ipairs(opts.keys) do
			vim.keymap.set(map.mode or 'n', map[1], function()
				vim.print(name)
				load_plugin(name)
				map[2](plugins[name].package)
			end, {
				desc = map.desc,
			})
		end
	end
end

vim.api.nvim_create_autocmd('VimEnter', {
	once = true,
	callback = function()
		for plugin, opts in pairs(plugins) do
			if opts.is_instant then
				load_plugin(plugin)
			end
		end
	end,
})

vim.api.nvim_create_user_command('Update', function()
	vim.pack.update(nil, {})
end, {})
