return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function lsp_clients()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return "No LSP"
      end

      local names = {}
      for _, client in ipairs(clients) do
        names[#names + 1] = client.name
      end
      return table.concat(names, ",")
    end

    require("lualine").setup({
      options = {
        theme = "auto",
      },
      sections = {
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = { lsp_clients, "encoding", "fileformat", "filetype" },
      },
    })
  end,
}
