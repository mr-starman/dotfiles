-- Cobol stuff (move to plugin?)
vim.cmd([[
  augroup cobol_autocommands
    autocmd!
    autocmd BufRead,BufNewFile *.cpy,*.ddr,*.sel,*.fil,*.rec,*.iom set filetype=cobol
    autocmd FileType cobol setlocal makeprg=iscc\ -c=resources/iscobol.properties
    autocmd FileType cobol setlocal errorformat=--%[A-Z]:\ #%n\ %m;\ file\ =\ %f\\,\ line\ =\ %l\\,\ col\ %c
    autocmd FileType cobol setlocal wildignore=*/run*/*,*/errs*/*
    autocmd FileType cobol setlocal suffixesadd=.cbl
  augroup END
]])
