return {
	'akinsho/toggleterm.nvim', version = "*", config = true,
	config = function()
		vim.keymap.set('n', '<c-d>', '<c-c><cmd>ToggleTerm<cr>')
	end
}
