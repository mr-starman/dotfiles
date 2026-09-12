return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      {
        "<C-p>",
        function()
          require("telescope.builtin").find_files({ cwd = require("config.project").root() })
        end,
        desc = "Find files",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>g",
        function()
          require("telescope.builtin").live_grep({ cwd = require("config.project").root() })
        end,
        desc = "Live grep",
      },
      {
        "<leader>bl",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Search current buffer",
      },
      {
        "<leader>bg",
        function()
          require("telescope.builtin").live_grep({ grep_open_files = true })
        end,
        desc = "Grep open buffers",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
      telescope.load_extension("ui-select")
    end,
  },
}
