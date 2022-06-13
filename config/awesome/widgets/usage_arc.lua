local wibox     = require "wibox"
local helpers   = require "helpers"
local beautiful = require "beautiful"
local awful     = require "awful"
local theme     = beautiful.widgets.usage_arc

local create = function(args)

    local container = wibox({
        height = args.size,
        width = args.size,
        bg = "#00000000",
        ontop = true,
        visible = true,
    })

    args.size = beautiful.dpi(args.size)
    local scale = args.size / 100

    local textbox = wibox.widget {
        markup = helpers.colorize_text(args.markup, args.color),
        font = args.icon_font .. " " .. args.font_size * scale,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    local arcchart = wibox.widget {
        textbox,
        max_value = args.max_value,
        values = { 0, 0 },
        colors = { theme.arc.bg_color, args.color },
        thickness = theme.arc.thickness * scale,
        start_angle = math.pi,
        visible = true,
        widget = wibox.container.arcchart
    }

    local show_percentage = false
    local old_usage = 0
    local widget_functions = {
        update_usage = function(usage)
            if show_percentage then
                textbox:set_markup_silently(helpers.colorize_text(usage .. '%', args.color))
            end
            arcchart.values = { args.max_value - usage, usage }
            old_usage = usage
        end
    }

    awful.widget.watch(args.usage_watch.command, args.usage_watch.interval, args.usage_watch.callback, widget_functions)

    container:setup {
        {
            arcchart,
            widget = wibox.container.margin,
            margins = theme.margin * scale
        },
        -- The real background color
        bg = theme.bg_color,
        -- The real, anti-aliased shape
        shape = helpers.rrect(theme.corner_radius * scale),
        forced_width = args.size,
        forced_height = args.size,
        widget = wibox.container.background()
    }

    local widget = container.widget

    -- Add button to switch between icon and percentage
    widget:add_button(awful.button ({ "Any" }, awful.button.names.LEFT,
        function ()
            show_percentage = not show_percentage
            local text
            if show_percentage then
                textbox.font = theme.percentage_font .. " " .. theme.font_size * scale
                text = old_usage .. '%'
            else
                textbox.font = args.icon_font .. " " .. args.font_size * scale
                text = args.markup
            end
            textbox:set_markup_silently(helpers.colorize_text(text, args.color))
        end
    ))

    -- Change cursor when hovering
    local old_cursor, old_wibox
    widget:connect_signal("mouse::enter", function (c)
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand2"
    end)
    widget:connect_signal("mouse::leave", function (c)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)



    return widget

end

return create