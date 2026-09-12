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
      end, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))
      vim.keymap.set("n", "[h", function()
        gitsigns.nav_hunk("prev")
      end, vim.tbl_extend("force", opts, { desc = "Previous git hunk" }))

      vim.keymap.set(
        "n",
        "<leader>hs",
        gitsigns.stage_hunk,
        vim.tbl_extend("force", opts, { desc = "Stage hunk" })
      )
      vim.keymap.set(
        "n",
        "<leader>hr",
        gitsigns.reset_hunk,
        vim.tbl_extend("force", opts, { desc = "Reset hunk" })
      )
      vim.keymap.set("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, vim.tbl_extend("force", opts, { desc = "Stage selected hunk" }))
      vim.keymap.set("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, vim.tbl_extend("force", opts, { desc = "Reset selected hunk" }))

      vim.keymap.set(
        "n",
        "<leader>hS",
        gitsigns.stage_buffer,
        vim.tbl_extend("force", opts, { desc = "Stage buffer" })
      )
      vim.keymap.set(
        "n",
        "<leader>hR",
        gitsigns.reset_buffer,
        vim.tbl_extend("force", opts, { desc = "Reset buffer" })
      )
      vim.keymap.set(
        "n",
        "<leader>hp",
        gitsigns.preview_hunk,
        vim.tbl_extend("force", opts, { desc = "Preview hunk" })
      )
      vim.keymap.set(
        "n",
        "<leader>hb",
        gitsigns.blame_line,
        vim.tbl_extend("force", opts, { desc = "Blame line" })
      )
      vim.keymap.set(
        "n",
        "<leader>hd",
        gitsigns.diffthis,
        vim.tbl_extend("force", opts, { desc = "Diff this" })
      )
      vim.keymap.set("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, vim.tbl_extend("force", opts, { desc = "Diff against previous revision" }))
    end,
  },
}
