MiniDeps.add('nvim-mini/mini.icons')

MiniDeps.now(function()
  require("mini.icons").setup()
  MiniIcons.mock_nvim_web_devicons()
end)

MiniDeps.add('nvim-mini/mini.animate')
MiniDeps.now(function()
  local animate = require("mini.animate")
  local timing = animate.gen_timing.linear({
    duration=100,
    unit="total"
  })
  animate.setup({
    cursor = {
      timing = timing
    }
  })
end)

MiniDeps.add('nvim-mini/mini.indentscope')

MiniDeps.now(function()
  local indentscope = require("mini.indentscope")
  indentscope.setup({
    animation = indentscope.gen_animation.quadratic()
  })
end)

MiniDeps.add({
  source = 'nvim-neo-tree/neo-tree.nvim',
  checkout = 'v3.x',
  depends = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  }
})
