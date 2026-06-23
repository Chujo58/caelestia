local loader = require("dynamic.loader")
local palette = require("dynamic.palette")
local highlights = require("dynamic.highlights")

local M = {}

local scheme_path = vim.fn.expand("~/.local/state/caelestia/scheme.json")

function M.setup()
  local scheme = loader.load(scheme_path)
  if not scheme then
    return
  end

  -- light/dark awareness
  if scheme.mode == "dark" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end

  local p = palette.from_scheme(scheme)
  highlights.apply(p)
end

-- auto-reload when scheme.json changes
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "scheme.json",
  callback = function()
    M.setup()
  end,
})

return M
