local plugins = {}

local function load_plugin(name)
	local opts = plugins[name]

	if not opts then
		vim.print('Plugin ' .. name .. ' does not exist')
		return
	end

	if opts.is_loaded then
		return
	end

	if opts.is_loading then
		vim.print('Circular deps in ' .. name)
		return
	end

	opts.is_loading = true

	if opts.deps then
		for _, plugin in ipairs(opts.deps) do
			load_plugin(plugin)
		end
	end

	if not opts.is_local then
		vim.pack.add {
			{
				src = 'https://github.com/' .. opts.src,
				version = opts.version,
			},
		}
	end

	if not opts.skip_require then
		opts.package = require(name)
	end

	if opts.user_load then
		opts.user_load(opts.package)
	else
		opts.package.setup(opts.user_opts)
	end

	opts.is_loaded = true
end

__.add_plugin = function(opts)
	local src = opts[1]
	local name = opts.dir or opts.name or src:match('/([%w_.-]+)$'):gsub('%.nvim$', '')

	if opts.enabled == false then
		return
	end

	-- TODO add duplicate check
	plugins[name] = {
		is_instant = true,
		is_loaded = false,
		deps = opts.deps,
		user_opts = opts.opts,
		src = src,
		is_local = opts.dir ~= nil,
		user_load = opts.load,
		skip_require = opts.skip_require,
	}

	if opts.is_theme then
		plugins[name].is_instant = false

		load_plugin(name)
	end

	if opts.cmds then
		plugins[name].is_instant = false

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
		plugins[name].is_instant = false

		vim.api.nvim_create_autocmd(opts.event, {
			once = true,
			callback = function()
				load_plugin(name)
			end,
		})
	end

	if opts.keys then
		plugins[name].is_instant = false

		for _, map in ipairs(opts.keys) do
			vim.keymap.set(map.mode or 'n', map[1], function()
				load_plugin(name)
				map[2](plugins[name].package)
			end)
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
