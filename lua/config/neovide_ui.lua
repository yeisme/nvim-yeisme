-- ============================================================================
-- Neovim UI 美化配置 - 针对 Neovide 优化
-- ============================================================================

-- 仅在 Neovide 环境下加载此配置
if not vim.g.neovide then
  return
end

-- ============================================================================
-- 隐藏 GUI 元素
-- ============================================================================
-- 完全隐藏菜单栏、工具栏和标签栏
vim.opt.guioptions = ""

-- ============================================================================
-- 编辑器美化 - 暗色主题
-- ============================================================================
-- 设置 Neovim 背景为深黑色，匹配 Neovide 背景
-- 重要：使用固定颜色代替透明，以避免白色背景问题
vim.cmd([[
  highlight! NormalFloat guibg=#1e1e1e guifg=#e0e0e0
  highlight! FloatBorder guibg=#1e1e1e guifg=#61afef
  highlight! NormalNC guibg=#1e1e1e guifg=#b0b0b0
  highlight! Normal guibg=#1e1e1e guifg=#e0e0e0
  highlight! EndOfBuffer guibg=#1e1e1e guifg=#3e3e3e
]])

-- ============================================================================
-- 浮动窗口样式优化 - 深色主题
-- ============================================================================
-- 设置浮动窗口边框样式为圆角
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Popup 菜单样式 - 暗色优化
vim.cmd([[
  highlight! Pmenu guibg=#2d2d2d guifg=#e0e0e0
  highlight! PmenuSel guibg=#0098ff guifg=#ffffff gui=bold
  highlight! PmenuSbar guibg=#3e3e3e
  highlight! PmenuThumb guibg=#61afef
]])

-- ============================================================================
-- 光标和选择区域美化 - 暗色主题
-- ============================================================================
-- 增强光标样式
vim.cmd([[
  highlight! Cursor guibg=#61afef guifg=#1e1e1e
  highlight! TermCursor guibg=#61afef guifg=#1e1e1e
  highlight! IncSearch guibg=#ff9500 guifg=#1e1e1e gui=bold
  highlight! Search guibg=#ff9500 guifg=#1e1e1e
]])

-- ============================================================================
-- 诊断消息样式 - 错误、警告等 - 暗色优化
-- ============================================================================
vim.cmd([[
  highlight! DiagnosticSignError guifg=#ff5555 guibg=NONE
  highlight! DiagnosticSignWarn guifg=#ffaa00 guibg=NONE
  highlight! DiagnosticSignInfo guifg=#61afef guibg=NONE
  highlight! DiagnosticSignHint guifg=#00d4ff guibg=NONE
  
  highlight! DiagnosticVirtualTextError guifg=#ff5555 guibg=NONE gui=italic
  highlight! DiagnosticVirtualTextWarn guifg=#ffaa00 guibg=NONE gui=italic
  highlight! DiagnosticVirtualTextInfo guifg=#61afef guibg=NONE gui=italic
  highlight! DiagnosticVirtualTextHint guifg=#00d4ff guibg=NONE gui=italic
]])

-- ============================================================================
-- 状态栏美化 - 暗色主题
-- ============================================================================
-- 移除模式指示器背景
vim.cmd([[
  highlight! ModeMsg guifg=#00d4ff gui=bold
  highlight! MoreMsg guifg=#00ff00
  highlight! StatusLine guibg=#2d2d2d guifg=#e0e0e0
  highlight! StatusLineNC guibg=#1e1e1e guifg=#808080
]])

-- ============================================================================
-- 缩进线美化 - 暗色主题
-- ============================================================================
-- 优化缩进导向线颜色
vim.cmd([[
  highlight! IndentBlanklineChar guifg=#3e3e3e
  highlight! IndentBlanklineContextChar guifg=#61afef
]])

-- ============================================================================
-- 代码行号美化 - 暗色主题
-- ============================================================================
vim.cmd([[
  highlight! LineNr guifg=#666666
  highlight! CursorLineNr guifg=#61afef gui=bold
  highlight! CursorLine guibg=#2d2d2d
]])

-- ============================================================================
-- 窗口分割线美化 - 暗色主题
-- ============================================================================
-- 隐藏分割线背景色
vim.cmd([[
  highlight! VertSplit guifg=#3e3e3e guibg=NONE
  highlight! WinSeparator guifg=#3e3e3e guibg=NONE
]])

-- ============================================================================
-- 补全菜单和弹出窗口 - 暗色主题
-- ============================================================================
vim.cmd([[
  highlight! NvimTreeNormal guibg=#1e1e1e guifg=#e0e0e0
  highlight! NvimTreeEndOfBuffer guibg=#1e1e1e
  highlight! NvimTreeCursorLine guibg=#2d2d2d
]])

-- ============================================================================
-- Neovide 特定优化
-- ============================================================================
-- 禁用光标线阴影以获得更清晰的界面
if vim.g.neovide then
  -- 平滑的光标过渡
  vim.g.neovide_cursor_animation_length = 0.15
  
  -- 隐藏所有 GUI 元素
  vim.cmd([[
    set guioptions=
  ]])
end
