local plugin = Custom.plugin

plugin.later(function()
  plugin.add({
    source = "MeanderingProgrammer/render-markdown.nvim",
    depends = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons',
    }
  })
  require('render-markdown').setup({
    file_types = { "markdown", "Avante" },
  })
end)
