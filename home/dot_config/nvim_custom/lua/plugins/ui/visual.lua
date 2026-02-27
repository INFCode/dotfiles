local plugin = Custom.plugin

MiniDeps.add('nvim-mini/mini.icons')

plugin.now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
end)

MiniDeps.add('nvim-mini/mini.animate')
plugin.now(function()
  local animate = require("mini.animate")
  local timing = animate.gen_timing.linear({
    duration = 100,
    unit = "total"
  })
  animate.setup({
    cursor = {
      timing = timing
    }
  })
end)

MiniDeps.add('nvim-mini/mini.indentscope')

plugin.later(function()
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    animation = indentscope.gen_animation.quadratic()
  })
end)

-- peeks lines of the buffer in non-obtrusive way
MiniDeps.add('nacro90/numb.nvim')

plugin.later(function()
  require('numb').setup()
end)


-- pattern-based highlighting
MiniDeps.add('nvim-mini/mini.hipatterns')
plugin.later(function()
  require('mini.hipatterns').setup({
    highlighters = {
      fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
      hack  = { pattern = 'HACK', group = 'MiniHipatternsHack' },
      todo  = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
      note  = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
    }
  })
end)
