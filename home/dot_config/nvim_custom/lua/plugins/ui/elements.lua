local plugin = Custom.plugin

MiniDeps.add({
  source = 'nvim-neo-tree/neo-tree.nvim',
  checkout = 'v3.x',
  depends = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  }
})

plugin.now(function()
  require("neo-tree").setup({
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "NC",   -- or "" to use 'winborder' on Neovim v0.11+
    enable_git_status = true,
    enable_diagnostics = true,
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
    event_handlers = {
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            local min_width = 30
            local max_width = 60
            local target_width = math.min(math.max(math.floor(vim.o.columns * 0.2), min_width), max_width)
            vim.api.nvim_win_set_width(args.winid, target_width)
          end
        end,
      },
    },
  })
  Custom.helpers.keymap("n", "<leader>nt", "<Cmd>Neotree toggle<CR>", "Toggle Neo-tree")
end)

MiniDeps.add("nvim-mini/mini.statusline")

plugin.now(function()
  require('mini.statusline').setup()
end)

MiniDeps.add("nvim-mini/mini.notify")
plugin.now(require("mini.notify").setup)

MiniDeps.add("nvim-mini/mini.pick")
plugin.later(require("mini.pick").setup)
