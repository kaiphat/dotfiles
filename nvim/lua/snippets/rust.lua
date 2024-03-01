local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local i = ls.insert_node

return function(M)
	return {
		pr = fmt([[ println!("\x1b[36m{2}: {{:?}}\x1b[0m", {1}); ]], {
			i(1),
			M.change(function(str) return str end),
		}),

		db = fmt([[ dbg!({}); ]], {
			i(1),
		}),
	}
end
