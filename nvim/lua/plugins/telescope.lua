return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.6',
	dependencies = { 
		'nvim-lua/plenary.nvim',
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			'nvim-telescope/telescope-fzf-native.nvim',

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = 'make',

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
	},
	config = function()
		pcall(require('telescope').load_extension, 'fzf')
		local builtin = require("telescope.builtin")
		vim.keymap.set('n', '<C-p>', builtin.find_files)
		vim.keymap.set('n', '<leader>b', builtin.buffers)
		vim.keymap.set('n', '<leader>g', builtin.live_grep)
		vim.keymap.set('n', '<leader>bl', builtin.current_buffer_fuzzy_find)
	end
}
