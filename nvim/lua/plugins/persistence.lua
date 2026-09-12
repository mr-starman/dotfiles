return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    {
      "<leader>Ss",
      function()
        require("persistence").load()
      end,
      desc = "Restore session",
    },
    {
      "<leader>Sl",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last session",
    },
    {
      "<leader>Sd",
      function()
        require("persistence").stop()
      end,
      desc = "Stop session persistence",
    },
  },
  opts = {},
}
