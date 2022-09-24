local awful      = require "awful"
local wibox      = require "wibox"
local beautiful  = require "beautiful"
local theme      = beautiful.widgets.tasklist

local tasklist = {}

-- Button Functions
local tasklist_buttons = awful.util.table.join(
    -- Left click - Toggle clicked client
    awful.button({}, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    { raise = true }
                )
            end
        end
    )
)

-- Create the tag list widget
tasklist.create = function(s)
    return awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_width  = theme.spacer.width,
                    thickness     = theme.spacer.thickness,
                    color         = theme.spacer.color,
                    widget        = wibox.widget.separator
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            spacing = theme.spacing,
            layout  = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                {
                    awful.widget.clienticon,
                    margins = 2,
                    widget  = wibox.container.margin
                },
                layout = wibox.layout.align.vertical,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    }
end

return tasklist
