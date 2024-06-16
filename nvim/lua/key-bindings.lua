-- Normal mode mappings
vim.keymap.set('i', '<leader>s', '<C-c><cmd>up<cr>')
vim.keymap.set('n', '<c-j>', '<esc><cmd>m .+1<cr>')
vim.keymap.set('n', '<c-k>', '<esc><cmd>m .-2<cr>')
vim.keymap.set('n', '<c-p>', '<c-c><cmd>Files<cr>')
vim.keymap.set('n', '<leader>a', '<c-6>')
vim.keymap.set('n', '<leader>b', '?')
vim.keymap.set('n', '<leader>cp', '<cmd>wincmd l \\| close<cr>')
vim.keymap.set('n', '<leader>f', '/')
vim.keymap.set('n', '<leader>h', '^')
vim.keymap.set('n', '<leader>l', '$')
vim.keymap.set('n', '<leader>m', '<cmd>update<cr><cmd>echo "compiling..."<cr><cmd>silent make %<cr><cr><cmd>cwindow<cr><cmd>echo ""<cr>')
vim.keymap.set('n', '<leader>n', '<cmd>bn<cr>')
vim.keymap.set('n', '<leader>o', 'o<esc>')
vim.keymap.set('n', '<leader>O', 'O<esc>')
vim.keymap.set('n', '<leader>p', '"0p')
vim.keymap.set('n', '<leader>P', '"0P')
vim.keymap.set('n', '<leader>p', '<cmd>bp<cr>')
vim.keymap.set('n', '<leader>pf', '<cmd>vsp \\| find <cfile> \\| wincmd p<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>up<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>noh<cr>')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'Y', 'y$')

-- Insert mode mappings
vim.keymap.set('i', '(', '()<esc>i', { noremap = true })
vim.keymap.set('i', '<c-j>', '<esc><cmd>m .+1<cr>==gi')
vim.keymap.set('i', '<c-k>', '<esc><cmd>m .-2<cr>==gi')
vim.keymap.set('i', 'jj', '<esc>')

-- Visual mode mappings
vim.keymap.set('v', '<c-j>', "<cmd>m '>+1<CR>gv=gv")
vim.keymap.set('v', '<c-k>', "<cmd>m '<-2<CR>gv=gv")

-- Terminal mode mappings
vim.keymap.set('t', '<silent><c-j>', '<C-\\><c-n><cmd>resize -5\\|normal i<cr>')
vim.keymap.set('t', '<silent><c-k>', '<C-\\><c-n><cmd>resize +5\\|normal i<cr>')
