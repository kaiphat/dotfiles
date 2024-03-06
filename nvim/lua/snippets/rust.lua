local function change(func, index)
	local ls = require 'luasnip'
	index = index or 1

	return ls.function_node(function(args)
		local str = args[1][1]

		return { func(str) or '' }
	end, { index })
end

local pr = [[
    println!("\x1b[36m{2}: {{:?}}\x1b[0m", {1});
]]

return {
	init = function()
		local ls = require 'luasnip'
		local fmt = require('luasnip.extras.fmt').fmt

		local i = ls.insert_node
		local s = ls.snippet

		ls.add_snippets('rust', {
			s(
				'pr',
				fmt(pr, {
					i(1),
					change(function(str)
						return str
					end),
				})
			),
		})
	end,
}
