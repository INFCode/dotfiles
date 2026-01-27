MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter',
  -- No need to checkout `main` branch as it is already the default
  -- checkout = 'main',
  -- Update tree-sitter parser after plugin is updated
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter-textobjects',
  -- Use `main` branch since `master` branch is frozen, yet still default
  -- It is needed for compatibility with 'nvim-treesitter' `main` branch
  checkout = 'main',
})
MiniDeps.add({
  source = 'nvim-treesitter/nvim-treesitter-context',
})

local install_missing_parsers = function(languages)
  local need_install = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end

  local to_install = vim.tbl_filter(need_install, languages)
  if #to_install > 0 then
    require('nvim-treesitter').install(to_install)
  end
end

local setup_ts_textobject = function()
  require("nvim-treesitter-textobjects").setup {
    select = {
      -- use mini.ai instead
      enable = false,
    },
    move = {
      -- Add jumps to jumplist (so you can <C-o>/<C-i> back/forward)
      set_jumps = true, -- default
    },
  }
end

-- Enable tree-sitter after opening a file for a target language
local get_ts_filetypes = function(languages)
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  return filetypes
end

local register_textobject_keymap_move = function()
  local ts_move        = require("nvim-treesitter-textobjects.move")
  local map            = _G.Custom.helpers.keymap

  -- helper: bind move
  local bind_move      = function(lhs, method, query, group, desc)
    map({ "n", "x", "o" }, lhs, function()
      ts_move[method](query, group)
    end, desc)
  end

  -- helper: bind move common logic
  local bind_move_comm = function(query_name, key_name, is_next, is_start)
    local lhs_prefix = is_next and "]" or "["
    local lhs_key
    if type(key_name) == "table" then
      lhs_key = key_name[is_start and 1 or 2]
    else
      lhs_key = is_start and key_name or string.upper(key_name)
    end
    local lhs = string.format("%s%s", lhs_prefix, lhs_key)

    local method_direction = is_next and "next" or "previous"
    local method_target = is_start and "start" or "end"
    local method = string.format("goto_%s_%s", method_direction, method_target)

    local query = string.format("@%s.outer", query_name)

    local desc = string.format("[TS Move]: %s %s %s", method_direction, query_name, method_target)

    bind_move(lhs, method, query, "textobjects", desc)
  end

  local move_maps      = {
    { "]o", "goto_next_start", { "@loop.inner", "@loop.outer" }, "textobjects", "[TS move]: next loop start" },
    { "]s", "goto_next_start", "@local.scope",                   "locals",      "[TS move]: next scope start" },
  }

  for _, m in ipairs(move_maps) do
    bind_move(m[1], m[2], m[3], m[4], m[5])
  end

  local move_queries = {
    { "function",  "f" },
    { "class",     { "[", "]" } },
    { "parameter", "a" }
  }

  for _, m in ipairs(move_queries) do
    bind_move_comm(m[1], m[2], true, true)
    bind_move_comm(m[1], m[2], true, false)
    bind_move_comm(m[1], m[2], false, true)
    bind_move_comm(m[1], m[2], false, false)
  end
end

local register_autocmd = function(filetypes)
  local ts_start = function(ev)
    register_textobject_keymap_move()
    vim.treesitter.start(ev.buf)
  end
  _G.Custom.helpers.autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end

MiniDeps.now(function()
  local languages = _G.Custom.config.languages
  install_missing_parsers(languages)
  setup_ts_textobject()

  local ts_filetypes = get_ts_filetypes(languages)
  register_autocmd(ts_filetypes)
end)
