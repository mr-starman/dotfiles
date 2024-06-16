return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup()
		vim.keymap.set('n', '<c-d>', '<c-c><cmd>ToggleTerm<cr>')
	end
}
