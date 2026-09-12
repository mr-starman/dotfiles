return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>b", group = "buffers" },
      { "<leader>c", group = "code" },
      { "<leader>d", group = "diagnostics/debug" },
      { "<leader>f", group = "files" },
      { "<leader>g", group = "grep/go to" },
      { "<leader>h", group = "git hunks" },
      { "<leader>j", group = "jumps/harpoon" },
      { "<leader>l", group = "lint" },
      { "<leader>p", group = "project/previous" },
      { "<leader>s", group = "search/save" },
      { "<leader>S", group = "sessions" },
      { "<leader>u", group = "ui" },
      { "<leader>x", group = "trouble" },
      { "<leader>y", group = "yank register" },
    },
  },
}
