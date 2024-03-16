local pr = [[
    println!("{2}: {{:?}}", {1});
]]

return {
	init = function()
		local ls = require 'luasnip'
		local fmt = require('luasnip.extras.fmt').fmt
		local rep = require('luasnip.extras').rep

		local i = ls.insert_node
		local s = ls.snippet

		ls.add_snippets('rust', {
			s(
				'pr',
				fmt(pr, {
					i(1),
                    rep(1),
				})
			),
		})
	end,
}
