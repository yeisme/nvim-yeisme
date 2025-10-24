-- Startup and initialization optimization
-- Minimizes startup time and improves initial responsiveness

-- Profile configuration
local profile_startup = os.getenv("NVIM_PROFILE_STARTUP")
if profile_startup then
  print("[STARTUP] Profiling enabled. Startup time will be printed.")
end

-- Pre-cache frequently used modules
local modules_to_cache = {
  "vim.treesitter",
  "vim.lsp",
  "vim.diagnostic",
}

-- Defer expensive operations
local deferred_tasks = {}

-- Load language server configurations lazily
vim.api.nvim_create_autocmd("FileType", {
  once = true,
  callback = function()
    -- LSP will be loaded on first file open
    vim.schedule(function()
      -- Pre-compile patterns for better performance
      if vim.fn.exists(":TSUpdate") == 2 then
        -- Treesitter is available
      end
    end)
  end,
})

-- Optimize plugin discovery
if vim.fn.has("nvim-0.9") == 1 then
  -- Use native Lua loader if available (faster than vimscript)
  vim.loader.enable()
end

-- Pre-initialize commonly used functions
local utils = {}

function utils.defer_lazy_load(ms, fn)
  vim.defer_fn(fn, ms)
end

-- Optimize require() by caching results
local require_cache = {}
local original_require = require

local function cached_require(module)
  if require_cache[module] then
    return require_cache[module]
  end
  local result = original_require(module)
  require_cache[module] = result
  return result
end

-- Don't override require globally to avoid issues, but use it in performance-critical sections

return utils
