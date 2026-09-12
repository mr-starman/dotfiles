-- Normal mode mappings
vim.keymap.set("i", "<leader>s", "<C-c><cmd>up<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>a", "<c-6>", { desc = "Alternate buffer" })
vim.keymap.set("n", "<leader>?", "?", { desc = "Search backward" })
vim.keymap.set("n", "<leader>cp", "<cmd>wincmd l \\| close<cr>", { desc = "Close right split" })
vim.keymap.set("n", "<leader>f", "/", { desc = "Search forward" })
vim.keymap.set("n", "gh", "^", { desc = "First non-blank character" })
vim.keymap.set("n", "gl", "$", { desc = "End of line" })
vim.keymap.set(
  "n",
  "<leader>m",
  '<cmd>update<cr><cmd>echo "compiling..."<cr><cmd>silent make %<cr><cr><cmd>cwindow<cr><cmd>echo ""<cr>',
  { desc = "Make current file" }
)
vim.keymap.set("n", "<leader>n", "<cmd>bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>o", "o<esc>", { desc = "Insert line below" })
vim.keymap.set("n", "<leader>O", "O<esc>", { desc = "Insert line above" })
vim.keymap.set("n", "<leader>p", "<cmd>bp<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>yp", '"0p', { desc = "Paste last yank after cursor" })
vim.keymap.set("n", "<leader>yP", '"0P', { desc = "Paste last yank before cursor" })
vim.keymap.set(
  "n",
  "<leader>pf",
  "<cmd>vsp \\| find <cfile> \\| wincmd p<cr>",
  { desc = "Open file under cursor" }
)
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>s", "<cmd>up<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader><space>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "n", "nzz", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous search result" })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
vim.keymap.set("n", "v", "<c-v>", { desc = "Visual block mode" })
vim.keymap.set("n", "U", "<c-r>", { desc = "Redo" })

-- Insert mode mappings
vim.keymap.set("i", "<c-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<c-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
vim.keymap.set("i", "jj", "<esc>", { desc = "Exit insert mode" })

-- Visual mode mappings
vim.keymap.set("v", "<c-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<c-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Terminal mode mappings
vim.keymap.set(
  "t",
  "<silent><c-j>",
  "<C-\\><c-n><cmd>resize -5\\|normal i<cr>",
  { desc = "Shrink terminal" }
)
vim.keymap.set(
  "t",
  "<silent><c-k>",
  "<C-\\><c-n><cmd>resize +5\\|normal i<cr>",
  { desc = "Grow terminal" }
)
