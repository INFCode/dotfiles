local M = {}

local register_plugin = function()
  MiniDeps.add({
    source = "neovim/nvim-lspconfig"
  })
end

local setup_hook = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "Go to definition")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "K", vim.lsp.buf.hover, "Hover")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("n", "<leader>fd", vim.diagnostic.open_float, "Line diagnostics")
    end,
  })
end

local setup_capabilities = function()
  local blink = require("blink.cmp")
  local capabilities = blink.get_lsp_capabilities()
  vim.lsp.config("*", { capabiliteis = capabilities })
end

local enable_servers = function(ls_by_ft)
  local ls_servers = vim.iter(vim.tbl_values(ls_by_ft or {})):flatten():totable()
  vim.lsp.enable(ls_servers)
end

function M.setup(ls_by_ft)
  register_plugin()
  MiniDeps.now(function()
    setup_hook()
    setup_capabilities()
    enable_servers(ls_by_ft)
  end)
end

return M
