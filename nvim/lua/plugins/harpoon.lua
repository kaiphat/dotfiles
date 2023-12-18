local base_keys = '<leader>h'

local keys = {
	{
		base_keys .. 'a',
		function()
			local h = require 'harpoon'
			h:list():append()
			print('added to ' .. h:list():length() .. ' mark')
		end,
	},
	{
		base_keys .. 'r',
		function()
			local h = require 'harpoon'
			h:list():remove()
			print 'removed'
		end,
	},
	{
		base_keys .. 'm',
		function()
			local h = require 'harpoon'
			h.ui:toggle_quick_menu(h:list())
		end,
	},
	{
		base_keys .. 'n',
		function()
			local h = require 'harpoon'
			h:list():next { ui_nav_wrap = true }
		end,
	},
	{
		base_keys .. 'p',
		function()
			local h = require 'harpoon'
			h:list():prev { ui_nav_wrap = true }
		end,
	},
	{
		base_keys .. 'c',
		function()
			local h = require 'harpoon'
			h:list():clear()
			print 'clear'
		end,
	},
}

local marks = 'qwerasdf'
for i = 1, #marks do
	local mark = marks:sub(i, i)
	table.insert(keys, {
		base_keys .. mark,
		function()
			local h = require 'harpoon'
            if i > h:list():length() then
                print(i..' not found')
            end
			h:list():select(i)
			print('selected ' .. i)
		end,
	})
end

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	requires = { 'nvim-lua/plenary.nvim' },
	keys = keys,
	config = function()
		require('harpoon'):setup {
			settings = {
				ui_nav_wrap = true,
			},
		}
	end,
}
