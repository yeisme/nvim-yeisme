-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 加载 Neovide 配置
require("config.neovide")
require("config.neovide_background")
require("config.neovide_ui")

-- 字体设置：使用系统已安装的 Consolas（如果要用 Nerd Font，需要先安装，见下方注释）
vim.o.guifont = "JetBrainsMono Nerd Font:h14"
vim.o.shell = "pwsh"
vim.o.shellcmdflag = ""

-- Better display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Performance
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Code folding
vim.opt.foldenable = false
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

-- Visual tweaks
vim.opt.cursorline = true
vim.opt.colorcolumn = "120"
vim.opt.signcolumn = "yes"
vim.opt.statusline = "%< %f %h%m%r%=%-14.(%l,%c%V%) %P"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10
