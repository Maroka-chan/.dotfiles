local wibox     = require "wibox"
local beautiful = require "beautiful"
local theme     = beautiful.widgets.menu_clock

-- Time widget
local time = wibox.widget.textclock()
time.format = '<span foreground="' .. theme.text_color  .. '">' .. theme.format .. '</span>'
time.align = "center"
time.font = theme.font .. " " .. theme.font_size

return time
