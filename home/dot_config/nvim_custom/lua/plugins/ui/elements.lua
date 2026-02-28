local plugin = Custom.plugin

plugin.now(function()
  plugin.add("nvim-mini/mini.statusline")
  require('mini.statusline').setup()
end)

plugin.now(function()
  plugin.add("nvim-mini/mini.notify")
  require("mini.notify").setup()
end)
