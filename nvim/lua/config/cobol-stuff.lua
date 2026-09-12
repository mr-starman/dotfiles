local cobol_group = vim.api.nvim_create_augroup("cobol_autocommands", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = cobol_group,
  pattern = { "*.cpy", "*.ddr", "*.sel", "*.fil", "*.rec", "*.iom" },
  callback = function()
    vim.bo.filetype = "cobol"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = cobol_group,
  pattern = "cobol",
  callback = function()
    vim.opt_local.makeprg = "iscc -c=resources/iscobol.properties"
    vim.opt_local.errorformat = "--%[A-Z]: #%n %m; file = %f\\, line = %l\\, col %c"
    vim.opt_local.wildignore = { "*/run*/*", "*/errs*/*" }
    vim.opt_local.suffixesadd = ".cbl"
  end,
})
