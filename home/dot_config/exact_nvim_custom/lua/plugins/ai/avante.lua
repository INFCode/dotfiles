local make_avante = function(args)
  local path = args.path
  vim.notify("Building avante.nvim...", vim.log.levels.INFO)
  local notify_result = function(result)
    if result.code == 0 then
      vim.notify("Successfully built avante.nvim", vim.log.levels.INFO)
    else
      vim.notify("Failed to build avante.nvim, error code = " .. result.code, vim.log.levels.ERROR)
      vim.notify("Stdout: " .. result.stdout, vim.log.levels.ERROR)
      vim.notify("Stderr: " .. result.stderr, vim.log.levels.ERROR)
    end
  end
  vim.system({ "make" }, { cwd = path }, notify_result)
end

MiniDeps.add({
  source = 'yetone/avante.nvim',
  monitor = 'main',
  depends = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.icons'
  },
  hooks = {
    post_install = make_avante,
    post_checkout = make_avante,
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
