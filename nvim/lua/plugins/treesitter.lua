-- Code Tree Support / Syntax Highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = "VeryLazy",
  build = ":TSUpdate",

  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  opts = {
    ensure_installed = {
      "lua",
      "markdown",
      "markdown_inline",
    },

    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = {
      enable = true,
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
