local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt

local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node

return function(M)
	return {
		co = fmt('console.log(\'%o\', {})', {
			i(1),
		}),

		im = fmt([[ import {{ {} }} from '{}' ]], {
			i(2, 'from'),
			i(1, 'name'),
		}),

		try = fmt([[
            try {{
                {}
            }} catch(e) {{

            }}
		]], i(1)),

		dea = fmt([[
            describe('{}', () => {{

            }})
		]], i(1)),

		def = fmt([[
            describe('{}', function () {{

            }})
		]], i(1)),

		ita = fmt([[
            it('{}', () => {{

            }})
		]], i(1)),

		itf = fmt([[
            it('{}', function () {{

            }})
		]], i(1)),

		af = fmt([[
            () => {{
                {}
            }}
		]], i(1)),
    }
end
