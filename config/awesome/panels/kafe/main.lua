local beautiful     = require "beautiful"
local wibox         = require "wibox"
local awful         = require "awful"
local taglist       = require "widgets.taglist"
local tasklist      = require "widgets.tasklist"
local layout_widget = require "widgets.layout"
local clock_widget  = require "widgets.clock"
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
        height = s.geometry.height,
        width = theme.width,
        bg = "#00000000",  -- Make transparent and set shape in :setup to get anti aliased corners
        ontop = true
    })

    main_panel:setup {
        {
            expand = "none",
            layout = wibox.layout.align.vertical,
            { -- First section
                {
                    layout = wibox.layout.fixed.vertical,
                    tasklist.create(s)
                },
                widget = wibox.container.margin,
                margins = theme.section_1.padding
            },
            { -- Second section
                {
                    layout = wibox.layout.fixed.vertical,
                    taglist.create(s)
                },
                widget = wibox.container.margin,
                margins = theme.section_2.padding
            },
            { -- Third section
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = theme.widget_spacing,
                    clock_widget,
                    layout_widget.create(s)
                },
                widget = wibox.container.margin,
                margins = theme.section_3.padding
            }
        },
        -- The real background color
        bg = theme.bg_color,
        widget = wibox.container.background()
    }


    -- ===================================================================
    -- Functionality
    -- ===================================================================

    -- hide main_panel when client is fullscreen
    local function below_on_fullscreen(client)
        if client.screen == s then
            main_panel.ontop = not client.fullscreen
        end
    end

    local function hide_panel(screen)
        if screen == s then
            main_panel.visible = false
        end
    end

    local function show_panel(screen)
        if screen == s then
            main_panel.visible = true
        end
    end

    -- connect visibility function to relevant signals
    client.connect_signal("property::fullscreen", below_on_fullscreen)
    client.connect_signal("focus", below_on_fullscreen)
    awesome.connect_signal("mainpanel::hide", hide_panel)
    awesome.connect_signal("mainpanel::show", show_panel)

end


return panel
