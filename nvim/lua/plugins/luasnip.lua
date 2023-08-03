local M = {}

M.change = function(func, index)
  local ls = require 'luasnip'

  index = index or 1

  return ls.function_node(function(args)
    local str = args[1][1]

    return { func(str) or '' }
  end, { index })
end

M.set_mappings = function()
  local ls = require 'luasnip'

  map({ 'i', 's' }, '<C-e>', function()
    ls.jump(1)
  end)
  map({ 'i', 's' }, '<C-d>', function()
    ls.change_choice(1)
  end)
end

M.add_rust_snippets = function()
  local ls = require 'luasnip'
  local fmt = require('luasnip.extras.fmt').fmt

  local s = ls.snippet
  local i = ls.insert_node

  ls.add_snippets('rust', {
    s(
      'pr',
      fmt(
        [[
            println!("\x1b[36m{2}: {{:?}}\x1b[0m", {1});
        ]],
        {
          i(1),
          M.change(function(str)
            return str
          end),
        }
      )
    ),

    s(
      'db',
      fmt(
        [[
            dbg!({});
          ]],
        {
          i(1),
        }
      )
    ),
  })
end

M.add_javascript_snippets = function()
  local ls = require 'luasnip'
  local fmt = require('luasnip.extras.fmt').fmt

  local s = ls.snippet
  local t = ls.text_node
  local c = ls.choice_node
  local i = ls.insert_node

  ls.add_snippets('javascript', {
    s(
      'co',
      fmt('console.dir({{ {} }}, {{ depth: 9 }})', {
        i(1),
      })
    ),

    s(
      'nc', -- new class
      fmt(
        [[
            export class {} {{
            }}
          ]],
        {
          i(1, 'ClassName'),
        }
      )
    ),

    s(
      'im', -- import
      fmt(
        [[
            import {{ {} }} from '{}'
          ]],
        {
          i(2, 'from'),
          i(1, 'name'),
        }
      )
    ),

    s(
      'nm', -- new async method
      fmt(
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
      )
    ),

    s(
      'nf', -- new function
      fmt(
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
      )
    ),

    s(
      'naf', -- new async function
      fmt(
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
      )
    ),

    s(
      'in', -- inject
      fmt(
        [[
            @Inject() private readonly {2}!: {1}
          ]],
        {
          i(1, 'name'),
          M.change(function(str)
            return str:gsub('%a', string.lower, 1)
          end),
        }
      )
    ),

    s(
      'map', -- inject
      fmt(
        [[
            const {} = {}.map(({}) => {{
              return {}
            }})
          ]],
        {
          M.change(function(name)
            return name:sub(1, #name - 1)
          end),
          i(1, 'list'),
          M.change(function(name)
            return name:sub(1, #name - 1)
          end),
          M.change(function(name)
            return name:sub(1, #name - 1)
          end),
        }
      )
    ),

    s(
      'red', -- reduce
      fmt(
        [[
            const {} = {}.reduce((acc, {}) => {{
              return acc
            }}, {{}})
          ]],
        {
          M.change(function(name)
            return name:sub(1, #name - 1)
          end),
          i(1, 'list'),
          M.change(function(name)
            return name:sub(1, #name - 1)
          end),
        }
      )
    ),

    s(
      'if', -- if
      fmt(
        [[
            if({}) {{
              {}
            }}
          ]],
        {
          i(1, 'condition'),
          i(2),
        }
      )
    ),

    s(
      'ifel', -- if else
      fmt(
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
      )
    ),

    s(
      'on', -- if else
      fmt(
        [[
              async onApplicationBootstrap() {{
                const a = await this.{}
                console.log('\x1b[36m%s\x1b[0m', JSON.stringify({{a}}, null, 2))
              }}
            ]],
        {
          i(1),
        }
      )
    ),
  })
end

return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require 'luasnip'

    ls.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      delete_check_events = 'TextChanged,InsertLeave',
    }

    M.set_mappings()

    M.add_javascript_snippets()
    M.add_rust_snippets()

    ls.filetype_extend('typescript', { 'javascript' })
    ls.filetype_extend('javascriptreact', { 'javascript' })
    ls.filetype_extend('typescriptreact', { 'javascript' })
  end,
}
