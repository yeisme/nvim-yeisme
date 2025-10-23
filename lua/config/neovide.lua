-- ============================================================================
-- Neovide 配置文件 - 高级美化配置
-- ============================================================================

-- 仅在 Neovide 环境下加载此配置
if not vim.g.neovide then
  return
end

-- ============================================================================
-- 窗口配置 - 无边框高级样式
-- ============================================================================
-- 禁用窗口装饰（无边框模式）
vim.g.neovide_unlink_border_highlights = true
vim.g.neovide_hide_mouse_when_typing = true

-- 初始化窗口大小
vim.g.neovide_scale_factor = 1.0

-- 窗口透明度配置 - 显示桌面背景
-- 关键：禁用窗口模糊，启用透明度以显示背景
vim.g.neovide_window_blurred = false  -- 禁用毛玻璃效果
vim.g.neovide_opacity = 0.85  -- 降低不透明度（0.85 = 85%不透明, 15%透明）
vim.g.neovide_hide_mouse_when_typing = true

-- 禁用窗口阴影（避免透明时出现阴影伪影）
vim.g.neovide_window_shadow = false

-- ============================================================================
-- 字体配置 - 高级渲染
-- ============================================================================
-- 字体名称（必须使用 Nerd Font 来显示文件图标）
-- 推荐：JetBrainsMono Nerd Font, FiraCode Nerd Font, Inconsolata Nerd Font
vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- 启用字体连字和高级渲染特性
vim.g.neovide_line_use_icons = true
vim.g.neovide_font_hinting = true

-- ============================================================================
-- 渲染配置 - 高性能优化
-- ============================================================================
-- 刷新率和帧率设置
vim.g.neovide_refresh_rate = 144
vim.g.neovide_frame_rate = 144

-- 启用 GPU 加速渲染
vim.g.neovide_profiling = true
vim.g.neovide_cursor_trail_length = 0.0

-- ============================================================================
-- 光标配置 - 高级视觉效果
-- ============================================================================
-- 光标动画启用，提供流畅的过渡
vim.g.neovide_cursor_animation_length = 0.15
vim.g.neovide_cursor_trail_length = 0.0

-- 光标 Vfx（visual effects）多种特效可选：
-- railgun: 轨道效果（强烈推荐）
-- torpedo: 鱼雷效果
-- pixiedust: 像素尘埃效果
-- sonicboom: 音速爆炸效果
-- ripple: 涟漪效果
vim.g.neovide_cursor_vfx_mode = "railgun"

-- 光标 Vfx 粒子特效参数
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
vim.g.neovide_cursor_vfx_particle_density = 7.0
vim.g.neovide_cursor_vfx_particle_speed = 15.0

-- ============================================================================
-- 动画配置 - 平滑过渡效果
-- ============================================================================
-- 启用平滑滚动动画
vim.g.neovide_scroll_animation_length = 0.15

-- 启用窗口阴影和浮动窗口效果
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 20

-- Float 窗口模糊效果（创建深度感）
vim.g.neovide_floating_blur_amount_x = 2.5
vim.g.neovide_floating_blur_amount_y = 2.5

-- ============================================================================
-- 高级美化配置
-- ============================================================================
-- 启用窗口边框模糊（创建毛玻璃效果）
vim.g.neovide_window_blurred = true

-- 隐藏鼠标光标
vim.g.neovide_hide_mouse_when_typing = true

-- 滚动条宽度（可选）
vim.g.neovide_scroll_bar_width = 10

-- ============================================================================
-- 性能和其他配置
-- ============================================================================
-- 强制使用暗色主题
vim.g.neovide_theme = "dark"

-- 隐藏顶部标签栏和菜单栏
vim.opt.guioptions = vim.opt.guioptions - "T" - "m" - "t"

-- 日志级别（开发调试用）
vim.g.neovide_debug = false
