-- ============================================================================
-- 缓冲区和文件处理优化配置
-- 针对不同文件类型和大小进行性能优化，提升大文件编辑体验
-- ============================================================================

local buffer_group = vim.api.nvim_create_augroup("BufferOptimization", { clear = true })

-- ============================================================================
-- 大文件性能优化：自动禁用对大文件的性能消耗功能
-- ============================================================================
vim.api.nvim_create_autocmd("BufReadPost", {
  group = buffer_group,
  callback = function(event)
    local buf = event.buf
    -- 获取文件大小（以字节为单位）
    local size = vim.fn.getfsize(event.file)
    
    -- 对于超过 1500KB 的文件，禁用以下功能以改善性能
    if size > 1500 * 1024 then
      -- 禁用交换文件：避免频繁的磁盘 I/O 操作
      vim.bo[buf].swapfile = false
      -- 禁用撤销文件：大文件的撤销历史会占用大量内存
      vim.bo[buf].undofile = false
      -- 禁用拼写检查：拼写检查在大文件上计算量很大
      vim.bo[buf].spell = false
      -- 禁用 LSP 诊断：LSP 分析大文件会导致明显卡顿
      vim.diagnostic.disable(buf)
    end
  end,
})

-- ============================================================================
-- 插入模式优化：提升输入响应速度
-- ============================================================================
-- 进入插入模式时的优化
vim.api.nvim_create_autocmd("InsertEnter", {
  group = buffer_group,
  callback = function()
    -- 在插入模式增加 updatetime（从 100ms 改为 300ms）
    -- 作用：减少 LSP 诊断和其他后台任务的更新频率，提升输入流畅度
    vim.opt_local.updatetime = 300
  end,
})

-- 离开插入模式时的恢复
vim.api.nvim_create_autocmd("InsertLeave", {
  group = buffer_group,
  callback = function()
    -- 恢复正常的 updatetime 以获得更快的诊断反馈
    vim.opt_local.updatetime = 100
  end,
})

-- ============================================================================
-- 终端缓冲区优化：隐藏不必要的 UI 元素
-- ============================================================================
vim.api.nvim_create_autocmd("TermOpen", {
  group = buffer_group,
  callback = function()
    -- 隐藏行号，终端中行号意义不大
    vim.opt_local.number = false
    -- 隐藏相对行号
    vim.opt_local.relativenumber = false
    -- 隐藏符号列（诊断图标等），节省屏幕空间
    vim.opt_local.signcolumn = "no"
  end,
})

-- ============================================================================
-- 文件类型特定的折叠优化
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  group = buffer_group,
  pattern = { "json", "yaml", "python", "lua" },
  callback = function()
    -- 对这些文件类型使用缩进级别来计算折叠
    vim.opt_local.foldmethod = "indent"
    -- 初始不折叠任何内容，避免打开文件时的折叠加载延迟
    vim.opt_local.foldlevel = 99
  end,
})

-- ============================================================================
-- 大数据文件（日志、CSV、SQL 等）的性能优化
-- ============================================================================
-- 预定义常见的大数据文件模式，避免每次都检查
local large_file_patterns = { "*.log", "*.csv", "*.sql", "*.json" }

vim.api.nvim_create_autocmd("FileType", {
  group = buffer_group,
  callback = function(event)
    -- 逐一检查文件是否匹配大数据文件模式
    for _, pattern in ipairs(large_file_patterns) do
      if event.file:match(pattern) then
        -- 禁用换行：大数据文件通常很宽，禁用换行避免渲染性能问题
        vim.opt_local.wrap = false
        -- 限制语法高亮的列数为 120，避免对过长行进行完整高亮
        vim.opt_local.synmaxcol = 120
        break
      end
    end
  end,
})

return {}
