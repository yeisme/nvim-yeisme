-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fast escape
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("v", "jk", "<Esc>", { desc = "Exit visual mode" })
vim.keymap.set("s", "jk", "<Esc>", { desc = "Exit select mode" })
vim.keymap.set("c", "jk", "<Esc>", { desc = "Exit command-line mode" })

-- Copy/Paste operations
vim.keymap.set("i", "cv", "<Esc>yyi", { desc = "Copy current line in insert mode" })
vim.keymap.set("v", "cv", '"+y', { desc = "Copy to system clipboard in visual mode" })
vim.keymap.set("s", "cv", '"+y', { desc = "Copy to system clipboard in select mode" })
vim.keymap.set("c", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard in command-line" })

-- Navigation improvements
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Window resizing
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "Decrease window height" })

-- Indentation in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Outdent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

-- Better undo/redo
vim.keymap.set("n", "<leader>z", "u", { desc = "Undo" })
vim.keymap.set("n", "<leader>Z", "<C-r>", { desc = "Redo" })

-- LSP Code Navigation (similar to VSCode - using Glance for better UX)
-- F12 / Ctrl+Click in VSCode: Go to Definition
vim.keymap.set("n", "<F12>", "<cmd>Glance definitions<CR>", { desc = "定义 (Glance)" })
vim.keymap.set("n", "gd", "<cmd>Glance definitions<CR>", { desc = "转到定义" })

-- Ctrl+F12 in VSCode: Go to Declaration
vim.keymap.set("n", "<C-F12>", "<cmd>Glance declarations<CR>", { desc = "声明 (Glance)" })
vim.keymap.set("n", "gD", "<cmd>Glance declarations<CR>", { desc = "转到声明" })

-- Ctrl+Shift+F10 in VSCode: Go to Implementation
vim.keymap.set("n", "<C-S-F10>", "<cmd>Glance implementations<CR>", { desc = "实现 (Glance)" })
vim.keymap.set("n", "gi", "<cmd>Glance implementations<CR>", { desc = "转到实现" })

-- Ctrl+Shift+Alt+F12 in VSCode: Go to Type Definition
vim.keymap.set("n", "go", "<cmd>Glance type_definitions<CR>", { desc = "转到类型定义" })

-- Shift+F12 in VSCode: Find All References
vim.keymap.set("n", "<S-F12>", "<cmd>Glance references<CR>", { desc = "查找所有引用" })
vim.keymap.set("n", "gr", "<cmd>Glance references<CR>", { desc = "查找引用" })

-- 额外快捷键组合 (leader 前缀)
vim.keymap.set("n", "<leader>gd", "<cmd>Glance definitions<CR>", { desc = "查找定义" })
vim.keymap.set("n", "<leader>gD", "<cmd>Glance declarations<CR>", { desc = "查找声明" })
vim.keymap.set("n", "<leader>gI", "<cmd>Glance implementations<CR>", { desc = "查找实现" })
vim.keymap.set("n", "<leader>gy", "<cmd>Glance type_definitions<CR>", { desc = "查找类型定义" })
vim.keymap.set("n", "<leader>gR", "<cmd>Glance references<CR>", { desc = "查找所有引用" })

-- LSP Actions
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename symbol (F2)" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format document" })

-- Diagnostics
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
