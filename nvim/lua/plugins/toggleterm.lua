return {
	'akinsho/toggleterm.nvim',
	config = function()
		require('toggleterm').setup {
			size = 17,
			open_mapping = [[<c-t>]],
		}
		vim.api.nvim_set_keymap('n', '<c-t>', ':ToggleTerm<CR>', { noremap = true, silent = true })
	end,
}
