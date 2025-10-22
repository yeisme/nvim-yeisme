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

-- LSP Code Navigation (similar to VSCode F12)
vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition (LSP)" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

-- LSP Actions
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover information" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format document" })

-- Diagnostics
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
