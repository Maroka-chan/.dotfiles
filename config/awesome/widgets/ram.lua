local beautiful  = require "beautiful"
local wibox      = require "wibox"
local awful      = require "awful"

-- RAM widget
local icon = wibox.widget {
    markup = '',
    font = 'JetBrains Mono Regular Nerd Font Complete Mono 18',
    widget = wibox.widget.textbox
}

local percent = wibox.widget {
    markup = '0%',
    font = "arial 10",
    widget = wibox.widget.textbox
}

local widget = {
    layout = wibox.layout.fixed.horizontal,
    forced_width = 45,
    spacing = beautiful.dpi(4),
    icon,
    percent
}

awful.widget.watch('cat /proc/meminfo', 15, function(w, stdout)
  local total = stdout:match 'MemTotal:%s+(%d+)'
  local free = stdout:match 'MemFree:%s+(%d+)'
  local buffers = stdout:match 'Buffers:%s+(%d+)'
  local cached = stdout:match 'Cached:%s+(%d+)'
  local srec = stdout:match 'SReclaimable:%s+(%d+)'
  local used_kb = total - free - buffers - cached - srec
  local usepercent = used_kb / total * 100

  -- Set text widget to usage percent
  percent:set_markup_silently(math.floor(usepercent) .. '%')
end, widget)

return widget
