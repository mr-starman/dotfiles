return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          check_outdated_packages_on_open = true,
          auto_update_packages = false,
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "bashls",
          "gopls",
          "html",
          "lua_ls",
          "ruff",
          "rust_analyzer",
          "tailwindcss",
          "taplo",
          "ts_ls",
        },
        automatic_installation = false,
        automatic_setup = false,
        automatic_enable = false,
        handlers = nil,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    lazy = false,
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = {
      ensure_installed = {
        "black",
        "codelldb",
        "debugpy",
        "eslint_d",
        "delve",
        "goimports",
        "isort",
        "jsonlint",
        "markdownlint",
        "prettier",
        "shfmt",
        "shellcheck",
        "stylua",
        "taplo",
        "vale",
        "yamllint",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      if vim.g.lsp_config_loaded then
        return
      end
      vim.g.lsp_config_loaded = true

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local servers = {
        tailwindcss = { capabilities = capabilities },
        html = { capabilities = capabilities },
        lua_ls = { capabilities = capabilities },
        gopls = { capabilities = capabilities },
        ts_ls = { capabilities = capabilities },
        taplo = { capabilities = capabilities },
        bashls = { capabilities = capabilities },
        basedpyright = { capabilities = capabilities },
        ruff = { capabilities = capabilities },
        rust_analyzer = {
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
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

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end

      vim.diagnostic.config({
        float = {
          border = "rounded",
          source = true,
        },
        severity_sort = true,
        virtual_text = {
          source = "if_many",
          spacing = 2,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local c = vim.lsp.get_client_by_id(args.data.client_id)
          if not c then
            return
          end
          if c and c.name == "ruff" then
            c.server_capabilities.hoverProvider = false
          end

          local opts = { buffer = args.buf }
          vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            vim.tbl_extend("force", opts, { desc = "Hover documentation" })
          )
          vim.keymap.set(
            "n",
            "<leader>gd",
            vim.lsp.buf.definition,
            vim.tbl_extend("force", opts, { desc = "Go to definition" })
          )
          vim.keymap.set(
            "n",
            "<leader>gr",
            vim.lsp.buf.references,
            vim.tbl_extend("force", opts, { desc = "Go to references" })
          )
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            vim.tbl_extend("force", opts, { desc = "Code action" })
          )
          vim.keymap.set(
            "n",
            "<space>rn",
            vim.lsp.buf.rename,
            vim.tbl_extend("force", opts, { desc = "Rename symbol" })
          )
        end,
      })

      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, { desc = "Next diagnostic" })
      vim.keymap.set(
        "n",
        "<leader>e",
        vim.diagnostic.open_float,
        { desc = "Open diagnostic float" }
      )
      vim.keymap.set("n", "<leader>dL", vim.diagnostic.setloclist, { desc = "Diagnostics loclist" })
      vim.keymap.set("n", "<leader>dQ", vim.diagnostic.setqflist, { desc = "Diagnostics quickfix" })
    end,
  },
}
