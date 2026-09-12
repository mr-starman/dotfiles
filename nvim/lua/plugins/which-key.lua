return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "diagnostics/debug" },
      { "<leader>g", group = "grep/go to" },
      { "<leader>h", group = "git hunks" },
      { "<leader>p", group = "project/previous" },
      { "<leader>x", group = "trouble" },
      { "<leader>y", group = "yank register" },
    },
  },
}
