local helpers = {}

-- Auto commands
local gr = vim.api.nvim_create_augroup('CustomCommands', { clear = true })
function helpers.autocmd(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

-- Keymaps
function helpers.keymap(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Index a table with another table
function helpers.index(tbl, index, flatten)
  if not index or index == {} then
    return {}
  end

  local result = {}
  for _, idx in ipairs(index) do
    local value = tbl[idx]

    if flatten then
      vim.list_extend(result, value or {})
    else
      result[idx] = value
    end
  end

  return result
end

return helpers
