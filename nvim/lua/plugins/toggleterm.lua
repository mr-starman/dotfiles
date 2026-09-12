return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 17,
      open_mapping = [[<c-t>]],
    })
  end,
}
