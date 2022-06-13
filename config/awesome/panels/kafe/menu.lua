local beautiful     = require "beautiful"
local wibox         = require "wibox"
local awful         = require "awful"
local helpers       = require "helpers"
local gears         = require "gears"
local theme         = beautiful.panels.menu

local date_widget   = require "widgets.date"

-- define module table
local panel = {}

-- ===================================================================
-- Panel Creation
-- ===================================================================

panel.create = function(s)

    local menu_panel = awful.wibar({
        screen = s,
        position = "right",
        height = s.geometry.height - theme.margin * 2,
        width = theme.width,
        bg = "#00000000",
        ontop = true,
        visible = false,
        margins = { left = theme.margin, right = theme.margin }
    })

    menu_panel:setup {
        {
            expand = "none",
            layout = wibox.layout.align.vertical,
            { -- Profile section
                {
                    layout = wibox.layout.fixed.vertical,
                    date_widget,
                    helpers.mask_image(beautiful.pfp, gears.shape.circle, theme.profile.size, theme.profile.size)
                },
                widget = wibox.container.margin,
                margins = theme.padding
            },
            { -- Second section
                {
                    layout = wibox.layout.fixed.vertical,
                },
                widget = wibox.container.margin,
                margins = theme.padding
            },
            { -- Third section
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = beautiful.wibar_spacing,
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
    -- functionality
    -- ===================================================================

    -- toggle panel
    local function toggle_panel(client)
        if client.screen == s then
            menu_panel.visible = not menu_panel.visible
        end
    end

    -- connect panel toggle function to relevant signals
    client.connect_signal("sidepanel::toggle", toggle_panel)

end

return panel
