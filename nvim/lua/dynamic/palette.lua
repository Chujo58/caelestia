local M = {}

function M.from_scheme(scheme)
  local c = scheme.colours

  return {
    -- editor basics
    bg = "#" .. c.background,
    fg = "#" .. c.onBackground,

    surface = "#" .. c.surfaceContainer,
    overlay = "#" .. c.surfaceVariant,

    comment = "#" .. c.subtext0,
    subtle = "#" .. c.subtext1,

    -- accents
    red = "#" .. c.error,
    green = "#" .. c.success,
    yellow = "#" .. c.tertiary,
    blue = "#" .. c.primary,
    magenta = "#" .. c.secondary,
    cyan = "#" .. c.teal,
  }
end

return M
