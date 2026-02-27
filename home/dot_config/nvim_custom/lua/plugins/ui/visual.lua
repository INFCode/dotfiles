local plugin = Custom.plugin

plugin.now(function()
  plugin.add('nvim-mini/mini.icons')
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
end)

plugin.now(function()
  plugin.add('nvim-mini/mini.animate')
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

plugin.later(function()
  plugin.add('nvim-mini/mini.indentscope')
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    animation = indentscope.gen_animation.quadratic()
  })
end)

-- peeks lines of the buffer in non-obtrusive way
plugin.later(function()
  plugin.add('nacro90/numb.nvim')
  require('numb').setup()
end)


-- pattern-based highlighting
plugin.later(function()
  plugin.add('nvim-mini/mini.hipatterns')
  require('mini.hipatterns').setup({
    highlighters = {
      fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
      hack  = { pattern = 'HACK', group = 'MiniHipatternsHack' },
      todo  = { pattern = 'TODO', group = 'MiniHipatternsTodo' },
      note  = { pattern = 'NOTE', group = 'MiniHipatternsNote' },
    }
  })
end)
