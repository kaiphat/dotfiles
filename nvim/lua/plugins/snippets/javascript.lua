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

		nc = fmt(
			[[
export class {} {{
}}
]],
			{
				i(1, 'ClassName'),
			}
		),

		im = fmt([[ import {{ {} }} from '{}' ]], {
			i(2, 'from'),
			i(1, 'name'),
		}),

		nm = fmt(
			[[
{}{}({}) {{
{}
}}
]],
			{
				c(1, {
					t 'async ',
					t '',
				}),
				i(2, 'name'),
				i(3, ''),
				i(4, ''),
			}
		),

		nf = fmt(
			[[
const {} = {}({}) => {{
const {}
return
}}
]],
			{
				i(1, 'name'),
				c(2, {
					t 'async ',
					t '',
				}),
				i(3),
				i(4),
			}
		),

		naf = fmt(
			[[
const {} = async ({}) => {{
{}
}}
]],
			{
				i(1, 'name'),
				i(2),
				i(3),
			}
		),

		['in'] = fmt(
			[[
@Inject() private readonly {2}!: {1}
]],
			{
				i(1, 'name'),
				M.change(function(str) return str:gsub('%a', string.lower, 1) end),
			}
		),

		map = fmt(
			[[
const {} = {}.map(({}) => {{
return {}
}})
]],
			{
				M.change(function(name) return name:sub(1, #name - 1) end),
				i(1, 'list'),
				M.change(function(name) return name:sub(1, #name - 1) end),
				M.change(function(name) return name:sub(1, #name - 1) end),
			}
		),

		red = fmt(
			[[
const {} = {}.reduce((acc, {}) => {{
return acc
}}, {{}})
]],
			{
				M.change(function(name) return name:sub(1, #name - 1) end),
				i(1, 'list'),
				M.change(function(name) return name:sub(1, #name - 1) end),
			}
		),

		['if'] = fmt(
			[[
if({}) {{
{}
}}
]],
			{
				i(1, 'condition'),
				i(2),
			}
		),

		ifel = fmt(
			[[
if({}) {{
{}
}} else {{
{}
}}
]],
			{
				i(1, 'condition'),
				i(2),
				i(3),
			}
		),

		['on'] = fmt(
			[[
async onApplicationBootstrap() {{
const a = await this.{}
console.log('\x1b[36m%s\x1b[0m', JSON.stringify({{a}}, null, 2))
}}
]],
			{
				i(1),
			}
		),
	}
end
