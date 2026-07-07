-- Options

vim.cmd.colorscheme 'retrobox'

vim.g.mapleader = " "
vim.g.maplocalleader = "ö"

if vim.g.neovide then
	vim.o.guifont = "AdwaitaMono Nerd Font:h12"
end

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.background = 'dark'
vim.o.textwidth = 120
vim.o.scrolloff = 5
vim.o.wrap = true
vim.o.winborder = 'rounded'
-- whitespace
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
