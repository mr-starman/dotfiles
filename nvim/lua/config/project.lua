local M = {}

local markers = {
  ".git",
  "Cargo.toml",
  "go.mod",
  "package.json",
  "pyproject.toml",
  "setup.py",
  "Makefile",
}

function M.root(bufnr)
  bufnr = bufnr or 0
  local name = vim.api.nvim_buf_get_name(bufnr)
  local start = name ~= "" and name or vim.uv.cwd()

  return vim.fs.root(start, markers) or vim.uv.cwd()
end

function M.cd()
  local root = M.root()
  vim.cmd.tcd(vim.fn.fnameescape(root))
  vim.notify("Project root: " .. root)
end

vim.api.nvim_create_user_command("ProjectRoot", M.cd, { desc = "Change tab cwd to project root" })

return M
