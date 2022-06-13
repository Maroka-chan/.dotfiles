local beautiful = require "beautiful"
local theme     = beautiful.widgets.ram

local usage_arc = require "widgets.usage_arc"

local ram_watch = function(widget, stdout)
  local total = stdout:match 'MemTotal:%s+(%d+)'
  local free = stdout:match 'MemFree:%s+(%d+)'
  local buffers = stdout:match 'Buffers:%s+(%d+)'
  local cached = stdout:match 'Cached:%s+(%d+)'
  local srec = stdout:match 'SReclaimable:%s+(%d+)'
  local used_kb = total - free - buffers - cached - srec
  local usepercent = used_kb / total * 100

  -- Set text widget to usage percent
  widget.update_usage(math.floor(usepercent))
end

local widget = usage_arc({
    markup = theme.markup,
    icon_font = theme.icon_font,
    font_size = theme.font_size,
    color = theme.color,
    max_value = 100,
    size = theme.size,
    usage_watch = {
        command = 'cat /proc/meminfo',
        interval = theme.update_interval,
        callback = ram_watch,
    }
})

return widget
