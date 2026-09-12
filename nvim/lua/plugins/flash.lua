return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash jump",
    },
    {
      "<leader>j",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({ search = { mode = "search", max_length = 0 } })
      end,
      desc = "Flash search jump",
    },
  },
}
