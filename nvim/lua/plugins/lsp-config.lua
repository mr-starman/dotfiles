return {
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = function()
			require('mason').setup {
				ui = {
					border = 'rounded',
				},
			}
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		'neovim/nvim-lspconfig',
		lazy = false,
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			local lspconfig = require 'lspconfig'
			lspconfig.tailwindcss.setup {
				capabilities = capabilities,
			}
			lspconfig.tsserver.setup {
				capabilities = capabilities,
			}
			lspconfig.solargraph.setup {
				capabilities = capabilities,
			}
			lspconfig.html.setup {
				capabilities = capabilities,
			}
			lspconfig.lua_ls.setup {
				capabilities = capabilities,
			}
			lspconfig.gopls.setup {
				capabilities = capabilities,
			}
			lspconfig.ocamllsp.setup {
				filetypes = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
				root_dir = lspconfig.util.root_pattern('*.opam', 'esy.json', 'package.json', '.git', 'dune-project', 'dune-workspace', '*.ml'),
				on_attach = on_attach,
				capabilities = capabilities,
			}
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.code_action, {})
			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
		end,
	},
}
