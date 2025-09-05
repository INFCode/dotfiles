-- Override some LazyVim defaults

return {
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    -- This is a temporary fix for catppuccin's breaking change
    -- Remove this once https://github.com/LazyVim/LazyVim/pull/6354 is merged
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      bufline.get = bufline.get_theme
    end,
  },
}
