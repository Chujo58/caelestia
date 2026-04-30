local M = {}

function M.load(path)
  local fd = io.open(path, "r")
  if not fd then
    return nil
  end

  local content = fd:read("*a")
  fd:close()

  return vim.json.decode(content)
end

return M
