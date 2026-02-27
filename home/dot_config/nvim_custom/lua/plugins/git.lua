local plugin = Custom.plugin

plugin.later(function()
  plugin.add("nvim-mini/mini-git")
  require('mini.git').setup()
end)

plugin.later(function()
  plugin.add("nvim-mini/mini.diff")
  require('mini.diff').setup()
end)
