return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			pcall(require('telescope').load_extension, 'fzf')
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<C-p>', builtin.find_files)
			vim.keymap.set('n', '<leader>b', builtin.buffers)
			vim.keymap.set('n', '<leader>g', builtin.live_grep)
			vim.keymap.set('n', '<leader>bl', builtin.current_buffer_fuzzy_find)
		end
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end
	}
}
