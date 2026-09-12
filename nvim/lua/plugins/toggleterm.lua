return {
  "akinsho/toggleterm.nvim",
  keys = {
    {
      "<C-t>",
      "<cmd>ToggleTerm<cr>",
      desc = "Toggle terminal",
    },
  },
  config = function()
    require("toggleterm").setup({
      size = 17,
      open_mapping = [[<c-t>]],
    })
  end,
}
