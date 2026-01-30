MiniDeps.add({
  source = "saghen/blink.cmp",
  checkout = "v1.8.0",
})


MiniDeps.later(function()
  require("blink.cmp").setup({
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false
        }
      },
      ghost_text = {
        enabled = true,
        show_without_selection = true
      }
    },
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    }
  })
end)
