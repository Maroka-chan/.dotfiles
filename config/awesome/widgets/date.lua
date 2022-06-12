local wibox = require "wibox"

-- Date widget
local date = wibox.widget.textclock()
date.format = "%a %d %b"
date.font = "sans 10"

return date
