MiniDeps.add({
  source = "neovim/nvim-lspconfig"
})

-- buffer-local keymaps on LspAttach
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


local setup_capabilities = function (configs)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink = require("blink.cmp")
  capabilities = blink.get_lsp_capabilities(capabilities)
  vim.lsp.config("*", { capabiliteis = capabilities })
end

local enable_ls = { "lua_ls" }

MiniDeps.now(function()
  setup_capabilities()
  vim.lsp.enable(enable_ls)
end)
