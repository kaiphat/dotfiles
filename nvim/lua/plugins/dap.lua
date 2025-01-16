return {
	{
		-- can't use it with docker container, because i should see process in host machine
		'mfussenegger/nvim-dap',
		enabled = false,
		config = function()
			local dap = require 'dap'

			dap.adapters['pwa-node'] = {
				type = 'server',
				host = 'localhost',
				port = '${port}',
				executable = {
					command = 'node',
					-- 💀 Make sure to update this path to point to your installation
					args = {
						vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
						'${port}',
					},
				},
			}

			for _, language in ipairs { 'typescript', 'javascript' } do
				dap.configurations[language] = {
					{
						type = 'pwa-node',
						request = 'launch',
						name = 'Launch file',
						program = '${file}',
						cwd = '${workspaceFolder}',
					},
					{
						type = 'pwa-node',
						request = 'attach',
						name = 'Attach',
						processId = require('dap.utils').pick_process,
						cwd = '${workspaceFolder}',
					},
				}
			end
		end,
	},

	{
		'rcarriga/nvim-dap-ui',
		enabled = false,
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio',
		},
		config = function()
			local dap = require 'dap'
			local dapui = require 'dapui'

			dap.listeners.before.attach.dapui_config = function()
				dapui.listeners()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeers.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dapui.setup {}
		end,
	},

	{
		'theHamsta/nvim-dap-virtual-text',
		enabled = false,
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
