local wibox     = require "wibox"
local beautiful = require "beautiful"

local theme     = beautiful.widgets.date

-- Date widget
local date = wibox.widget.textclock()
date.format = '<span foreground="' .. theme.text_color .. '">' .. theme.format .. '</span>'
date.align = theme.align
date.font = theme.font .. " " .. theme.font_size

return date
