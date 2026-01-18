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

-- Enable tree-sitter after opening a file for a target language
local get_ts_filetypes= function(languages)
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  return filetypes
end

local register_autocmd = function(filetypes)
  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)
  end
  _G.Config.autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end

-- Define languages which will have parsers installed and auto enabled
local languages = {
  -- pre-installed with Neovim
  'c',
  'lua',
  'markdown',
  'vimdoc',
  -- Add here more languages with which you want to use tree-sitter
  -- To see available languages:
  -- - Execute `:=require('nvim-treesitter').get_available()`
  -- - Visit 'SUPPORTED_LANGUAGES.md' file at
  --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
}

MiniDeps.later(function()
  install_missing_parsers(languages)
  local ts_filetypes = get_ts_filetypes(languages)
  register_autocmd(ts_filetypes)
end)
