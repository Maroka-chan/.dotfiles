local helpers   = require "helpers"
local beautiful = require "beautiful"
local wibox     = require "wibox"
local awful     = require "awful"

-- CPU widget
local icon = wibox.widget {
    markup = '',
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

local prevtotal = 0
local prevwork = 0
awful.widget.watch('cat /proc/stat', 5, function(w, stdout)
    local cpuinfo = stdout:match 'cpu%s+(.-)\n'
    local processes = helpers.split(cpuinfo, "%s")

    local total = 0
    for i, str in ipairs(processes) do
        total = total + tonumber(str)
    end

    local work = tonumber(processes[1]) + tonumber(processes[2]) + tonumber(processes[3])
    local work_over_period = work - prevwork
    local total_over_period = total - prevtotal

    local usepercent = work_over_period / total_over_period * 100

    -- Set text widget to usage percent
    percent:set_markup_silently(math.floor(usepercent) .. '%')

    prevtotal = total
    prevwork = work
end, widget)

return widget
