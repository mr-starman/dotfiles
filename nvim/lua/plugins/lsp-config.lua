return {
	{
		'williamboman/mason.nvim',
		lazy = false,
		version = '1.11.0',
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
		version = '1.32.0',
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
			lspconfig.ts_ls.setup {
				capabilities = capabilities,
			}
			lspconfig.csharp_ls.setup {
				capabilities = capabilities,
			}
			lspconfig.taplo.setup {
				capabilities = capabilities,
			}
			lspconfig.bashls.setup {
				capabilities = capabilities,
			}
			lspconfig.pylsp.setup {
				capabilities = capabilities,
			}
			lspconfig.rust_analyzer.setup {
				settings = {
					['rust-analyzer'] = {
						assist = {
							importMergeBehavior = 'last',
							importPrefix = 'by_self',
						},
						cargo = {
							loadOutDirsFromCheck = true,
						},
						procMacro = {
							enable = true,
						},
					},
				},
			}
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					-- Format the current buffer on save
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format { bufnr = args.buf, id = c.id }
						end,
					})
				end,
			})
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
			vim.keymap.set('n', '<leader>gh', vim.lsp.buf.hover, {})
			vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
		end,
	},
}
