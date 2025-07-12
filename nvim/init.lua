local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require 'config.vim-options'
require 'config.key-bindings'
require 'config.autocommands'
-- TODO: Move to custom Lazy plug?
require 'config.cobol-stuff'

require('lazy').setup('plugins', {
	ui = {
		border = 'rounded',
	},
})
