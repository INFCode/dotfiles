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


local setup_capabilities = function()
  local blink = require("blink.cmp")
  local capabilities = blink.get_lsp_capabilities()
  vim.lsp.config("*", { capabiliteis = capabilities })
end

local language_to_ls = {
  python = { "ty", "ruff" }
}

local default_ls = { "lua_ls" }

local ls_to_enable = function()
  local enabled_languages = _G.Custom.config.languages or {}
  local all_ls = default_ls
  for _, lang in ipairs(enabled_languages) do
    vim.list_extend(all_ls, language_to_ls[lang] or {})
  end
  return all_ls
end

MiniDeps.now(function()
  setup_capabilities()
  vim.lsp.enable(ls_to_enable())
end)
