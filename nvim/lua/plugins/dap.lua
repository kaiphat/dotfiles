local M = {}

M.setup_js_adapters = function()
	local dap = require 'dap'

	require('dap').adapters['pwa-node'] = {
		type = 'server',
		host = '127.0.0.1',
		port = 9229,
	}

	for _, language in ipairs { 'typescript', 'javascript' } do
		dap.configurations[language] = {
			{
				type = 'pwa-node',
				request = 'attach',
				name = 'Attach',
				processId = require('dap.utils').pick_process,
				cwd = '${workspaceFolder}',
			},
		}
	end
end

return {
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'mxsdev/nvim-dap-vscode-js',
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'

			dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
			dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
			dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

			M.setup_js_adapters()

			dapui.setup {}
		end,
	},

	{
		'theHamsta/nvim-dap-virtual-text',
		config = function()
			local d = require 'nvim-dap-virtual-text'

			d.setup {}
		end,
	},

	-- {
	-- 	'microsoft/vscode-js-debug',
	-- 	build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
	-- },
}
