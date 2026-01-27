MiniDeps.add({ source = 'echasnovski/mini.ai' })

local setup_mini_ai = function()
  local ai = require('mini.ai')
  ai.setup({
    n_lines = 100,
    custom_textobjects = {
      f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }),
      a = ai.gen_spec.treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
      o = ai.gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
      b = ai.gen_spec.treesitter({ a = '@block.outer', i = '@block.inner' }),
      s = ai.gen_spec.treesitter({ a = '@local.scope', i = '@local.scope' }),
    },
    search_method = 'cover',
  })
end

MiniDeps.now(setup_mini_ai)
