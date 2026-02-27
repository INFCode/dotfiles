local plugin = Custom.plugin

plugin.now(function()
  plugin.add("loctvl842/monokai-pro.nvim")
  require("monokai-pro").setup({
    filter = "ristretto"
  })
  vim.cmd.colorscheme("monokai-pro")
end)
