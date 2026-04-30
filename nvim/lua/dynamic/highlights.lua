local M = {}

function M.apply(p)
  local set = vim.api.nvim_set_hl

  vim.cmd("highlight clear")
  vim.o.termguicolors = true
  vim.g.colors_name = "dynamic-material"

  -- UI
  set(0, "Normal", { fg = p.fg, bg = p.bg })
  set(0, "CursorLine", { bg = p.surface })
  set(0, "LineNr", { fg = p.subtle })
  set(0, "CursorLineNr", { fg = p.blue, bold = true })
  set(0, "Visual", { bg = p.overlay })

  -- Syntax
  set(0, "Comment", { fg = p.comment, italic = true })
  set(0, "Keyword", { fg = p.magenta })
  set(0, "String", { fg = p.green })
  set(0, "Function", { fg = p.blue })
  set(0, "Type", { fg = p.yellow })
  set(0, "Constant", { fg = p.cyan })

  -- Diagnostics
  set(0, "DiagnosticError", { fg = p.red })
  set(0, "DiagnosticWarn", { fg = p.yellow })
  set(0, "DiagnosticInfo", { fg = p.blue })
  set(0, "DiagnosticHint", { fg = p.cyan })
end

return M
