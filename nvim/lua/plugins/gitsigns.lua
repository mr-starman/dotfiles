return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "]h", function()
        gitsigns.nav_hunk("next")
      end, opts)
      vim.keymap.set("n", "[h", function()
        gitsigns.nav_hunk("prev")
      end, opts)

      vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)
      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, opts)
      vim.keymap.set("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, opts)
      vim.keymap.set("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, opts)

      vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts)
      vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, opts)
      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)
      vim.keymap.set("n", "<leader>hb", gitsigns.blame_line, opts)
      vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, opts)
      vim.keymap.set("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, opts)
    end,
  },
}
