local M = {}

-- Use the nearest manifest so commands also work in workspace member crates.
function M.cargo(args)
  local root = vim.fs.root(0, "Cargo.toml")
  if not root then
    vim.notify("No Cargo.toml found for this buffer", vim.log.levels.WARN)
    return
  end
  vim.cmd.update()
  -- A plain :split shares the source buffer; starting a terminal in it would
  -- replace the source in both windows. Give each task its own scratch buffer.
  vim.cmd("botright 15new")
  vim.fn.jobstart(vim.list_extend({ "cargo" }, args), { cwd = root, term = true })
  vim.cmd.startinsert()
end

function M.on_attach(client, bufnr)
  local function map(key, callback, desc)
    vim.keymap.set("n", "<leader>r" .. key, callback, { buffer = bufnr, desc = desc })
  end

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
  map("h", function()
    local filter = { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
  end, "Rust toggle inlay hints")
  map("b", function()
    M.cargo({ "build" })
  end, "Rust build crate")
  map("r", function()
    M.cargo({ "run" })
  end, "Rust run crate")
  map("t", function()
    M.cargo({ "test" })
  end, "Rust test crate")
  map("T", function()
    M.cargo({ "test", "--workspace" })
  end, "Rust test workspace")
  map("c", function()
    M.cargo({ "clippy", "--all-targets" })
  end, "Rust Clippy")
  map("f", function()
    require("conform").format({ bufnr = bufnr, async = true, lsp_format = "fallback" })
  end, "Rust format buffer")
  map("d", vim.lsp.buf.definition, "Rust go to definition")
end

return M
