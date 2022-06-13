local helpers   = require "helpers"
local beautiful = require "beautiful"
local theme     = beautiful.widgets.cpu

local usage_arc = require "widgets.usage_arc"

-- Credit to Hitobat for the cpu usage calculation
-- https://stackoverflow.com/a/3017438
local prevtotal = 0
local prevwork = 0
local cpu_watch = function(widget, stdout)
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
    widget.update_usage(math.floor(usepercent))

    prevtotal = total
    prevwork = work
end

local widget = usage_arc({
    markup = theme.markup,
    icon_font = theme.icon_font,
    font_size = theme.font_size,
    color = theme.color,
    max_value = 100,
    size = theme.size,
    usage_watch = {
        command = 'cat /proc/stat',
        interval = theme.update_interval,
        callback = cpu_watch,
    }
})

return widget


