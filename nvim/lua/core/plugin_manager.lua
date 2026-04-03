local plugins = {}

local function load_plugin(name)
	vim.print(name)
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

	vim.pack.add {
		{
			src = 'https://github.com/' .. opts.src,
			version = opts.version,
		},
	}
	vim.print(plugins)

	if opts.deps then
		for _, plugin in ipairs(opts.deps) do
			load_plugin(plugin)
		end
	end

	plugins[name].load(name)
end

__.add_plugin = function(opts)
	-- waiting additional implementation
	if true then
		return
	end

	local name = opts[1]

	if opts.enabled == false then
		return
	end

	plugins[name] = {
		is_instant = false,
		is_loaded = false,
		deps = opts.deps,
		src = opts[2],
		load = opts.load or function()
			require(name).setup()
		end,
	}

	if opts.event then
		vim.api.nvim_create_autocmd(opts.event, {
			once = true,
			callback = function()
				load_plugin(name)
			end,
		})
	elseif opts.keys then
		vim.print 'not implemented'
	else
		plugins[opts[1]].is_instant = true
	end
end

vim.schedule(function()
	for plugin, opts in pairs(plugins) do
		if not opts.is_instant then
			return
		end

		load_plugin(plugin)
	end
end)
