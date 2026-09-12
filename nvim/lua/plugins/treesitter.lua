return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",

  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    treesitter.install({
      "bash",
      "c_sharp",
      "css",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    })

    vim.treesitter.language.register("c_sharp", "cs")
    vim.treesitter.language.register("javascript", "javascriptreact")
    vim.treesitter.language.register("tsx", "typescriptreact")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "bash",
        "c_sharp",
        "cs",
        "css",
        "go",
        "html",
        "java",
        "javascript",
        "javascriptreact",
        "json",
        "lua",
        "markdown",
        "python",
        "query",
        "rust",
        "toml",
        "typescript",
        "typescriptreact",
        "vim",
        "vimdoc",
        "yaml",
      },
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })
  end,
}
