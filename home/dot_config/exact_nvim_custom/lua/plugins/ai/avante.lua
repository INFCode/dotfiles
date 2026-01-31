MiniDeps.add({
  source = 'yetone/avante.nvim',
  monitor = 'main',
  depends = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.icons'
  },
  hooks = {
    post_checkout = function()
      vim.notify("Building avante.nvim", vim.log.levels.INFO)
      vim.cmd('make')
    end
  }
})

MiniDeps.later(function()
  require("avante").setup({
    provider = "deepseek",
    providers = {
      deepseek = {
        __inherited_from = "openai",
        api_key_name = "DEEPSEEK_API_KEY",
        endpoint = "https://api.deepseek.com",
        model = "deepseek-reasoner",
      },
    },
    selector = {
      provider = "mini_pick",
    },
    input = {
      provider = "native",
    },
    behavior = {
      -- only approve some generally safe operations
      auto_approve_tool_permissions = { 'cd', 'cat', 'ls', 'mkdir', 'touch', 'head', 'tail', 'grep' }
    }
  })
end)
