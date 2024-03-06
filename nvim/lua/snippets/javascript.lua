local try = [[
    try {{
        {}
    }} catch(e) {{

    }}
]]

local console = [[
    console.log('%o', {})
]]

local describe = [[
    describe('{}', function() {{
        {}
    }})
]]

local async_describe = [[
    describe('{}', async function() {{
        {}
    }})
]]

local default_import = [[
    import {} from '{}'
]]

local import = [[
    import {{{}}} from '{}'
]]

return {
	init = function()
		local ls = require 'luasnip'
		local fmt = require('luasnip.extras.fmt').fmt

		local s = ls.snippet
		local i = ls.insert_node
		local c = ls.choice_node
		local t = ls.text_node
		local r = ls.restore_node
		local sn = ls.snippet_node
		local rep = require('luasnip.extras').rep

		ls.add_snippets('javascript', {
			s('co', fmt(console, i(1))),

			s('try', fmt(try, i(1))),

			s('im', {
				c(1, {
                    fmt(default_import, { rep(1), i(1) }),
					fmt(import, { i(2), i(1) }),
				}),
			}),

			s('sde', {
				c(1, {
					fmt(describe, { i(1, 'description'), i(2) }),
					fmt(async_describe, { i(1, 'description'), i(2) }),
				}),
			}),
		})
	end,
}
