local beautiful = require "beautiful"
local theme     = beautiful.widgets.disk

local usage_arc = require "widgets.usage_arc"

local disk_watch = function(widget, stdout)
  -- Set text widget to usage percent
  widget.update_usage(math.floor(stdout))
end

local widget = usage_arc({
    markup = theme.markup,
    icon_font = theme.icon_font,
    font_size = theme.font_size,
    color = theme.color,
    max_value = 100,
    size = theme.size,
    usage_watch = {
        command = "df " .. theme.partition .. " | awk 'NR == 2 {print substr($5, 1, length($5)-1)}'",
        interval = theme.update_interval,
        callback = disk_watch,
    }
})

return widget


