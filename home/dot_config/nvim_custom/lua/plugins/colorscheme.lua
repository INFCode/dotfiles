MiniDeps.add({
  source = "loctvl842/monokai-pro.nvim"
})

MiniDeps.now(function() 
  require("monokai-pro").setup({
    filter = "ristretto"
  })
  vim.cmd.colorscheme("monokai-pro")
end)
