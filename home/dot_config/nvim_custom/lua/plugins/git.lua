MiniDeps.add("nvim-mini/mini-git")
MiniDeps.later(function() require('mini.git').setup() end)

MiniDeps.add("nvim-mini/mini.diff")
MiniDeps.later(function() require('mini.diff').setup() end)
