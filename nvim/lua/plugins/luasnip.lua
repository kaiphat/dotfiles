local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local types = require("luasnip.util.types")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

ls.add_snippets('javascript', {
  s('co',
    fmt("console.log('\\x1b[36m%s\\x1b[0m', JSON.stringify({{{}}}, null, 2))", {
      i(1)
    })
  ),
})

ls.add_snippets('rust', {
  s('pr',
    fmt([[
      println!("{{{}}}");
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

ls.add_snippets('lua', {
  s('im',
    fmt([[
      first {} second
      next {} item
    ]], {
      i(2, 'first'),
      i(1, 'second'),
    })
  ),
})

ls.filetype_extend('typescript', { 'javascript' })

