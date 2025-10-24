-- ============================================================================
-- Lazy.nvim 插件管理器配置
-- ============================================================================
-- Lazy.nvim 是一个高效的 Neovim 插件管理器，支持延迟加载以提升性能

-- 获取 Lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- ============================================================================
-- 引导程序：自动克隆 Lazy.nvim 仓库
-- ============================================================================
-- 检查 Lazy.nvim 是否已安装
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Lazy.nvim 的官方 GitHub 仓库地址
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- 执行 git clone 命令下载 Lazy.nvim
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  -- 检查克隆是否成功
  if vim.v.shell_error ~= 0 then
    -- 克隆失败时显示错误信息
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- 将 Lazy.nvim 路径添加到运行时路径，优先加载
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Lazy.nvim 初始化和配置
-- ============================================================================
require("lazy").setup({
  -- 插件规范配置
  spec = {
    -- 导入 LazyVim 提供的默认插件
    -- LazyVim 是一个预配置的 Neovim 配置框架，包含常用的插件和设置
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 导入项目自定义的插件配置（位于 lua/plugins 目录）
    { import = "plugins" },
  },
  
  -- ========================================================================
  -- 插件加载默认行为
  -- ========================================================================
  defaults = {
    -- 是否在启动时延迟加载自定义插件
    -- false：自定义插件在启动时立即加载（LazyVim 插件仍会延迟加载）
    -- true：所有插件都在需要时延迟加载
    lazy = false,
    
    -- 版本管理策略
    -- false：始终使用最新的 git 版本，避免过时的插件版本导致问题
    -- "*" 或版本号：使用特定版本（许多插件的版本标签已过时）
    version = false,
  },
  
  -- ========================================================================
  -- 安装配置
  -- ========================================================================
  -- 首次启动时安装的默认配色方案列表
  install = { colorscheme = { "tokyonight", "habamax" } },
  
  -- ========================================================================
  -- 插件更新检查
  -- ========================================================================
  checker = {
    -- 启用定期检查插件更新
    enabled = true,
    -- 发现更新时不显示通知（避免打扰工作）
    notify = false,
  },
  
  -- ========================================================================
  -- 性能优化配置
  -- ========================================================================
  performance = {
    -- 运行时路径（rtp）优化
    rtp = {
      -- 禁用不必要的内置 Neovim 运行时插件，加快启动速度
      disabled_plugins = {
        "gzip",                 -- gzip 文件编辑支持
        -- "matchit",            -- 百分比键导航（保留以兼容）
        -- "matchparen",         -- 括号高亮配对（保留以兼容）
        -- "netrwPlugin",        -- 内置文件浏览器（保留以兼容）
        "tarPlugin",            -- tar 文件编辑支持
        "tohtml",               -- 转换为 HTML
        "tutor",                -- 内置教程
        "zipPlugin",            -- zip 文件编辑支持
        "spellfile_plugin",     -- 拼写检查插件（按需启用）
        "fzf",                  -- fzf 模糊查找（如果不使用可禁用）
        "2to3",                 -- Python 2 到 3 转换器
      },
    },
    -- 重置包路径以改善启动速度
    reset_packpath = true,
  },
})
