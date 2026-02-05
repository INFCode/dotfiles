local make_avante = function(args)
  local path = args.path
  vim.notify("Building avante.nvim...", vim.log.levels.INFO)
  local notify_result = function(result)
    if result.code == 0 then
      vim.notify("Successfully built avante.nvim", vim.log.levels.INFO)
    else
      vim.notify("Failed to build avante.nvim, error code = " .. result.code, vim.log.levels.ERROR)
      vim.notify("Stdout: " .. result.stdout, vim.log.levels.ERROR)
      vim.notify("Stderr: " .. result.stderr, vim.log.levels.ERROR)
    end
  end
  vim.system({ "make" }, { cwd = path }, notify_result)
end

MiniDeps.add({
  source = 'yetone/avante.nvim',
  monitor = 'main',
  depends = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.icons'
  },
  hooks = {
    post_install = make_avante,
    post_checkout = make_avante,
  }
})


-- Configuration constants
local CUSTOM_CONFIG = {
  base_url = _G.Custom.config.custom_ai_url,
  cache_filename = "custom_protocol",
  curl_timeout = 5,
}

---Reads the cached protocol from file
local function read_cached_protocol(cache_file)
  local f = io.open(cache_file, "r")
  if not f then
    return nil
  end

  local content = f:read("*a")
  f:close()

  content = vim.trim(content)
  -- Validate cached content
  if content == "http://" or content == "https://" then
    return content
  end
  return nil
end

---Writes the protocol to cache file
local function write_cached_protocol(cache_file, protocol)
  local f, err = io.open(cache_file, "w")
  if not f then
    vim.notify("Failed to write Astra protocol cache: " .. (err or "unknown error"), vim.log.levels.WARN)
    return false
  end

  f:write(protocol)
  f:close()
  return true
end

---Detects the protocol by making an HTTP request
local function detect_protocol(base_url)
  local curl_cmd = string.format("curl -sS --max-time %d http://%s", CUSTOM_CONFIG.curl_timeout, base_url)
  local result = vim.fn.system(curl_cmd)

  -- If response contains "Need Https", use https; otherwise use http
  if string.find(result, "Need Https", 1, true) then
    return "https://"
  end
  return "http://"
end

---Gets the full Astra URL, using cached protocol if available
local function get_custom_url()
  local cache_file = vim.fn.stdpath("cache") .. "/" .. CUSTOM_CONFIG.cache_filename

  -- Try to read from cache first
  local protocol = read_cached_protocol(cache_file)

  if not protocol then
    -- No valid cache, detect protocol
    vim.notify("Failed to load cached Astra's protocol, detecting now. This may take a while...", vim.log.levels.INFO)
    protocol = detect_protocol(CUSTOM_CONFIG.base_url)
    vim.notify("Detection finished!", vim.log.levels.INFO)
    write_cached_protocol(cache_file, protocol)
  end

  return protocol .. CUSTOM_CONFIG.base_url
end

MiniDeps.later(function()
  local default_provider = "deepseek"
  local providers = {
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "DEEPSEEK_API_KEY",
      endpoint = "https://api.deepseek.com",
      model = "deepseek-reasoner",
    }
  }

  if _G.Custom.metadata.host_type == "work" then
    default_provider = "custom_kimi"
    providers["custom_kimi"] = {
      __inherited_from = "openai",
      api_key_name = "AC_TOKEN",
      endpoint = get_custom_url(),
      model = "kimi_k2d5_code/thinking",
    }
  end

  require("avante").setup({
    provider = default_provider,
    providers = providers,
    selector = {
      provider = "mini_pick",
    },
    input = {
      provider = "native",
    },
    behavior = {
      -- only approve some generally safe operations
      auto_approve_tool_permissions = { 'cd', 'cat', 'ls', 'mkdir', 'touch', 'head', 'tail', 'grep' }
    }
  })
end)
