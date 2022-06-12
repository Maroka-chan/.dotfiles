local beautiful     = require "beautiful"
local wibox         = require "wibox"
local awful         = require "awful"
local taglist      = require "widgets.taglist"
local layout_widget = require "widgets.layout"
local clock_widget  = require "widgets.clock"
local helpers       = require "helpers"
local theme         = beautiful.panels.main

-- define module table
local panel = {}

-- ===================================================================
-- Panel Creation
-- ===================================================================

-- Example on how to do anti aliased corners - https://github.com/elenapan/dotfiles/wiki/Rounded-corners

panel.create = function(s)

    local main_panel = awful.wibar({
        screen = s,
        position = "left",
        height = s.geometry.height - theme.margin * 2,
        width = theme.width,
        bg = "#00000000",  -- Make transparent and set shape in :setup to get anti aliased corners
        ontop = true,
        margins = { left = theme.margin, right = theme.margin }
    })

    main_panel:setup {
        {
            expand = "none",
            layout = wibox.layout.align.vertical,
            { -- First section
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = theme.widget_spacing,
                },
                widget = wibox.container.margin,
                margins = theme.padding
            },
            { -- Second section
                {
                    layout = wibox.layout.fixed.vertical,
                    taglist.create(s)
                },
                widget = wibox.container.margin,
                margins = theme.padding
            },
            { -- Third section
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = theme.widget_spacing,
                    clock_widget,
                    layout_widget.create(s)
                },
                widget = wibox.container.margin,
                margins = theme.padding
            }
        },
        -- The real background color
        bg = theme.bg_color,
        -- The real, anti-aliased shape
        shape = helpers.rrect(theme.corner_radius),
        widget = wibox.container.background()
    }


    -- ===================================================================
    -- Functionality
    -- ===================================================================

    -- hide main_panel when client is fullscreen
    local function change_panel_visibility(client)
        if client.screen == s then
            main_panel.ontop = not client.fullscreen
        end
    end

    -- connect visibility function to relevant signals
    client.connect_signal("property::fullscreen", change_panel_visibility)
    client.connect_signal("focus", change_panel_visibility)

end


return panel
