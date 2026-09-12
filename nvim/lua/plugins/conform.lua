return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },

  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      go = { "goimports", "gofmt" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "isort", "black" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      toml = { "taplo" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
