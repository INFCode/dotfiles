local language_tools = {
  python = {
    ls = { "ty", "ruff" },
    linter = {},
    formatter = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
  },
  lua = {
    ls = { "lua_ls" },
  },
  rust = {
    ls = { "rust_analyzer" }
  },
}

local languages = Custom.config.languages or {}
local active_language_tools = Custom.helpers.index(language_tools, languages)

local select_tools_by_ft = function(tool_key)
  local selected = {}
  for _, language in ipairs(languages) do
    local tools = active_language_tools[language]
    if tools and tools[tool_key] then
      selected[language] = tools[tool_key]
    end
  end
  return selected
end

require("plugins.coding.complete")
require("plugins.coding.format").setup(select_tools_by_ft("formatter"))
require("plugins.coding.lint").setup(select_tools_by_ft("linter"))
require("plugins.coding.lsp").setup(select_tools_by_ft("ls"))
