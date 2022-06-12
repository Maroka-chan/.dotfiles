local wibox     = require "wibox"
local beautiful = require "beautiful"
local mpc       = require "ui.widgets.lib.mpc"
local timer     = require "gears.timer"


-- Music widget that'll say what's currently playing
local icon = wibox.widget {
    markup = '',
    font = 'Font Awesome',
    widget = wibox.widget.textbox
}
local status = wibox.widget {
    markup = 'Nothing Playing',
    widget = wibox.widget.textbox
}

local widget = {
    layout = wibox.layout.fixed.horizontal,
    spacing = beautiful.dpi(4),
    icon,
    status
}


local state, title, artist, file = "stop", "", "", ""

local function update_widget()
    local text = ""
    text = tostring(title or "")
    if state == "pause" then
        text = text .. " (paused)"
    end
    if state == "stop" then
        text = text .. " (stopped)"
    end
    status:set_markup_silently(text)
end

local connection
local function error_handler(err)
    status:set_markup_silently("Error: " .. tostring(err))
    -- Try a reconnect soon-ish
    timer.start_new(10, function()
        connection:send("ping")
    end)
end

connection = mpc.new(nil, nil, nil, error_handler,
    "status", function(_, result)
        state = result.state
    end,
    "currentsong", function(_, result)
        title, artist, file = result.title, result.artist, result.file
        pcall(update_widget)
end)

return widget
