local plugin = Custom.plugin

MiniDeps.add("nvim-mini/mini-git")
plugin.later(function() require('mini.git').setup() end)

MiniDeps.add("nvim-mini/mini.diff")
plugin.later(function() require('mini.diff').setup() end)
