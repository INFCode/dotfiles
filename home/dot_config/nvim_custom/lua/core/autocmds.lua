-- restore the cursor position when opening files
local restore_cursor
restore_cursor = function()
  -- Cursor position before the last opening
  local last_pos = vim.fn.line("'\"")
  -- Total number of lines in the file
  local last_line = vim.fn.line("$")

  -- If the last cursor position is still valid
  if last_pos > 0 and last_pos <= last_line then
    -- Go there
    local col = vim.fn.col("'\"")
    vim.api.nvim_win_set_cursor(0, { last_pos, col - 1 })
  end
end

Custom.helpers.autocmd('BufReadPost', '*', restore_cursor, "Restore cursor position when re-opening files")
