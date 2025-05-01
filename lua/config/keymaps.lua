-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jk to escape
vim.keymap.set("i", "jk", "<Esc>", {
    desc = "退出插入模式"
})
vim.keymap.set("v", "jk", "<Esc>", {
    desc = "退出视觉模式"
})
vim.keymap.set("s", "jk", "<Esc>", {
    desc = "退出选择模式"
})
vim.keymap.set("c", "jk", "<Esc>", {
    desc = "退出命令行模式"
})

-- cv
vim.keymap.set("i", "cv", "<Esc>yyi", {
    desc = "插入模式下复制当前行"
})
vim.keymap.set("v", "cv", '"+y', {
    desc = "视觉模式下复制选中内容到系统剪贴板"
})
vim.keymap.set("s", "cv", '"+y', {
    desc = "选择模式下复制选中内容到系统剪贴板"
})
vim.keymap.set("c", "<C-v>", "<C-r>+", {
    desc = "命令行模式下粘贴系统剪贴板内容"
})
