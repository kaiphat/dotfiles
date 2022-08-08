local ls = load('luasnip')
if not ls then return end

local fmt = require('luasnip.extras.fmt').fmt
local rep = require("luasnip.extras").rep
local types = require("luasnip.util.types")

local s = ls.snippet
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node

local function change(func, index) 
  index = index or 1

  return f(function(args)
    local str = args[1][1] 

    return { func(str) or "" }
  end, { index })
end


local copy = function(args)
	return args[1]
end

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

-- JAVASCRIPT --

ls.add_snippets('javascript', {
  s('co',
    fmt("console.log('\\x1b[36m%s\\x1b[0m', JSON.stringify({{{}}}, null, 2))", {
      i(1)
    })
  ),

  s('nc', -- new class
    fmt(
    [[
      export class {} {{
      }}
    ]], {
      i(1, 'ClassName')
    })
  ),

  s('nm', -- new async method
    fmt(
    [[
      {}{}({}) {{
        {}
      }}
    ]], {
      c(1, {
        t('async '),
        t('')
      }),
      i(2, 'name'),
      i(3, ''),
      i(4, ''),
    })
  ),

  s('nf', -- new function
    fmt(
    [[
      const {} = {}({}) => {{
        const {}
        return
      }}
    ]], {
      i(1, 'name'),
      c(2, {
        t('async '),
        t('')
      }),
      i(3),
      i(4),
    })
  ),

  s('naf', -- new async function
    fmt(
    [[
      const {} = async ({}) => {{
        {}
      }}
    ]], {
      i(1, 'name'),
      i(2),
      i(3),
    })
  ),

  s('in', -- inject
    fmt(
    [[
      @Inject() private readonly {2}!: {1}
    ]], {
      i(1, 'name'),
      change(function(str)
        return str:gsub("%a", string.lower, 1)
      end)
    })
  ),

  s('map', -- inject
    fmt(
    [[
      const {} = {}.map(({}) => {{
        return {}
      }})
    ]], {
      change(function(name)
        return name:sub(1, #name - 1)
      end),
      i(1, 'list'),
      change(function(name)
        return name:sub(1, #name - 1)
      end),
      change(function(name)
        return name:sub(1, #name - 1)
      end),
    })
  ),

  s('red', -- reduce
    fmt(
    [[
      const {} = {}.reduce((acc, {}) => {{
        return acc
      }}, {{}})
    ]], {
      change(function(name)
        return name:sub(1, #name - 1)
      end),
      i(1, 'list'),
      change(function(name)
        return name:sub(1, #name - 1)
      end),
    })
  ),

  s('if', -- if
    fmt(
    [[
      if({}) {{
        {}
      }}
    ]], {
      i(1, 'condition'),
      i(2)
    })
  ),

  s('ifel', -- if else
    fmt(
    [[
      if({}) {{
        {}
      }} else {{
        {}
      }}
    ]], {
      i(1, 'condition'),
      i(2),
      i(3),
    })
  ),

})

-- RUST --

ls.add_snippets('rust', {
  s('pr',
    fmt([[
      println!("{{:?}}", {});
    ]], {
      i(1),
    })
  ),

  s('db',
    fmt([[
      dbg!({});
    ]], {
      i(1),
    })
  ),
})

ls.filetype_extend('typescript', { 'javascript' })
ls.filetype_extend('javascriptreact', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'javascript' })

