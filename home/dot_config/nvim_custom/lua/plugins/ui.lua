MiniDeps.add({
  source = 'nvim-neo-tree/neo-tree.nvim',
  checkout = 'v3.x',
  depends = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  }
})

MiniDeps.now(function()
  require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "NC",   -- or "" to use 'winborder' on Neovim v0.11+
    enable_git_status = true,
    enable_diagnostics = true,
  })
  _G.Config.keymap("n", "<leader>nt", "<Cmd>Neotree<CR>", "Toggle Neo-tree")
end)
