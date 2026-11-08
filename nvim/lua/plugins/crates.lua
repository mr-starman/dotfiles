return {
  "saecki/crates.nvim",
  ft = { "toml" },
  dependencies = { "hrsh7th/nvim-cmp", "nvim-lua/plenary.nvim" },
  config = function()
    require("crates").setup({
      completion = {
        cmp = {
          enabled = true,
        },
      },
    })
    local cmp = require("cmp")
    cmp.setup.filetype("toml", {
      sources = cmp.config.sources({ { name = "crates" } }, {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      }),
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("CargoCratesKeys", { clear = true }),
      pattern = "Cargo.toml",
      callback = function(event)
        local crates = require("crates")
        for key, action in pairs({
          h = { crates.show_popup, "Crate details" },
          v = { crates.show_versions_popup, "Crate versions" },
          f = { crates.show_features_popup, "Crate features" },
          u = { crates.update_crate, "Update crate within version requirement" },
          U = { crates.upgrade_crate, "Upgrade crate version requirement" },
        }) do
          vim.keymap.set(
            "n",
            "<leader>c" .. key,
            action[1],
            { buffer = event.buf, desc = action[2] }
          )
        end
      end,
    })
  end,
}
