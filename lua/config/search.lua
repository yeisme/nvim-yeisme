-- ============================================================================
-- 搜索功能增强和优化配置
-- ============================================================================

-- 优化搜索体验和响应速度
-- 启用实时搜索：边输入边显示搜索结果
vim.opt.incsearch = true
-- 搜索结果高亮显示
vim.opt.hlsearch = true
-- 默认不区分大小写进行搜索
vim.opt.ignorecase = true
-- 当搜索模式包含大写字母时自动切换到区分大小写
vim.opt.smartcase = true

-- ============================================================================
-- 搜索导航优化：改进搜索结果跳转体验
-- ============================================================================
-- 在正常模式下按 Enter 键清除搜索高亮
-- 这样不需要额外的快捷键组合就能清除高亮
vim.keymap.set("n", "<CR>", function()
  -- 如果命令行为空，则清除搜索高亮
  if vim.fn.getcmdline() == "" then
    vim.cmd("nohlsearch")
  end
  return "<CR>"
end, { expr = true, noremap = true })

-- ============================================================================
-- 搜索结果可见性增强：自动打开折叠显示搜索结果
-- ============================================================================
local search_highlight_group = vim.api.nvim_create_augroup("SearchHighlight", { clear = true })

-- 在命令行退出时（完成搜索时）触发
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = search_highlight_group,
  callback = function()
    -- 检查是否执行的是搜索命令（/ 或 ?）
    if vim.fn.getcmdtype():match("[/?]") then
      -- 延迟执行以确保搜索结果已显示
      vim.schedule(function()
        -- zv 命令：打开所有包含搜索结果的折叠，确保搜索结果可见
        vim.cmd("normal! zv")
      end)
    end
  end,
})

-- ============================================================================
-- 搜索高亮自动清除：空闲时自动清除搜索高亮
-- ============================================================================
-- 改进：在光标移动时检查搜索状态，空闲 1 秒后自动清除高亮
vim.api.nvim_create_autocmd("CursorMoved", {
  group = search_highlight_group,
  callback = function()
    -- 如果搜索方向为 0（无搜索），则不执行
    if vim.v.searchforward == 0 then
      -- 延迟 1 秒后清除搜索高亮，避免频繁清除导致闪烁
      vim.defer_fn(function()
        vim.cmd("nohlsearch")
      end, 1000)
    end
  end,
})

return {}
