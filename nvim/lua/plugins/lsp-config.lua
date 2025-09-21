return {
	{
		'mason-org/mason.nvim',
		lazy = false,
		config = function()
			require('mason').setup {
				ui = {
					border = 'rounded',
					check_outdated_packages_on_open = true,
					auto_update_packages = true,
				},
			}
		end,
	},
	{
		'mason-org/mason-lspconfig.nvim',
		lazy = false,
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = {},
				automatic_installation = false,
				automatic_setup = false,
				automatic_enable = false,
				handlers = nil,
			})
		end,
	},
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { "folke/neodev.nvim" },
    },
    lazy = false,
    config = function()
      if vim.g.lsp_config_loaded then
        return
      end
      vim.g.lsp_config_loaded = true

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Define your servers and their configs
      local servers = {
        tailwindcss = { capabilities = capabilities },
        solargraph  = { capabilities = capabilities },
        html        = { capabilities = capabilities },
        lua_ls      = { capabilities = capabilities },
        gopls       = { capabilities = capabilities },
        ts_ls       = { capabilities = capabilities },
        csharp_ls   = { capabilities = capabilities },
        taplo       = { capabilities = capabilities },
        bashls      = { capabilities = capabilities },
        pylsp       = { capabilities = capabilities },
        jdtls       = { capabilities = capabilities },
        rust_analyzer = {
          capabilities = capabilities,
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
        },
      }

      -- Register and enable each server
      for name, cfg in pairs(servers) do
        vim.lsp.config[name] = cfg
        vim.lsp.enable(name)
      end

      -- Autocommands
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

      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
    end,
  },
}
