-- Override some LazyVim defaults

return {
  -- Configure LazyVim to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    -- This is a temporary fix as venv-selector is moving back to its main branch again
    -- Remove this once the main branch is used for venv-selector
    "linux-cultist/venv-selector.nvim",
    branch = "main",
    enabled = false,
  },
}
