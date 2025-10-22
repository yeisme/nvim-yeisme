-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here with `vim.api.nvim_create_autocmd`
--
-- Remove existing autocmds by their group name (prefixed with `lazyvim_`)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-save on focus loss
vim.api.nvim_create_autocmd("FocusLost", {
  command = "silent! wa",
  desc = "Auto-save on focus loss"
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yanked text"
})

-- Auto-format on save (if you prefer auto-formatting)
-- Uncomment below to enable
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   command = "silent! Format",
--   desc = "Format on save"
-- })

-- Disable auto-comment in new line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
  desc = "Disable auto-comment"
})
