-- ============================================================================
-- Neovide 背景配置 - 透明显示桌面背景
-- ============================================================================

-- 仅在 Neovide 环境下加载此配置
if not vim.g.neovide then
  return
end

-- ============================================================================
-- 透明度配置 - 显示桌面背景
-- ============================================================================
-- 启用真正的透明效果来显示桌面背景
-- neovide_opacity: 0.0 = 完全透明, 1.0 = 完全不透明
-- 推荐值：0.80-0.90（80%-90%不透明）

vim.g.neovide_opacity = 0.85

-- 关键：禁用窗口模糊效果，这样才能看到背景
vim.g.neovide_window_blurred = false

-- ============================================================================
-- 背景颜色配置 - 设置编辑器自身的背景
-- ============================================================================
-- 注意：这里设置的是编辑器内容的背景，透明度会让桌面背景显示在后面
vim.g.neovide_background_color = "#1e1e1e"

-- ============================================================================
-- 确保所有元素支持透明显示
-- ============================================================================
vim.cmd([[
  " 主编辑区背景
  highlight! Normal guibg=#1e1e1e guifg=#e0e0e0
  
  " 非活跃窗口
  highlight! NormalNC guibg=#1e1e1e guifg=#b0b0b0
  
  " 命令行和消息区域
  highlight! CommandLine guibg=#1e1e1e guifg=#e0e0e0
  highlight! MsgArea guibg=#1e1e1e guifg=#e0e0e0
  
  " 浮动窗口（LSP、补全等）
  highlight! NormalFloat guibg=#252525 guifg=#e0e0e0
  highlight! FloatBorder guibg=#252525 guifg=#61afef
  
  " 确保行号区域不显示背景色（透明显示背景）
  highlight! LineNr guibg=NONE guifg=#666666
  highlight! CursorLineNr guibg=NONE guifg=#61afef gui=bold
  
  " 信号列（诊断符号）- 透明显示背景
  highlight! SignColumn guibg=NONE
  highlight! FoldColumn guibg=NONE
  
  " 状态栏
  highlight! StatusLine guibg=#2d2d2d guifg=#e0e0e0
  highlight! StatusLineNC guibg=#1e1e1e guifg=#808080
]])

-- ============================================================================
-- 透明度调整指南
-- ============================================================================
-- 如需调整透明度，修改 neovide_opacity 的值：
-- 
-- vim.g.neovide_opacity = 0.70  -- 70% 不透明（更透明，显示更多背景）
-- vim.g.neovide_opacity = 0.80  -- 80% 不透明（平衡）
-- vim.g.neovide_opacity = 0.90  -- 90% 不透明（较不透明，背景较暗）
-- vim.g.neovide_opacity = 1.00  -- 100% 不透明（完全不透明，无背景显示）

