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
                    helpers.spacer(40, "vertical"),
                    helpers.mask_image(beautiful.pfp, gears.shape.circle, theme.profile.pfp_size, theme.profile.pfp_size),
                    -- Text
                    wibox.widget{
                        markup = helpers.colorize_text(theme.profile.text.markup, theme.profile.text.color),
                        font = theme.profile.text.font .. " " .. theme.profile.text.font_size,
                        align  = 'center',
                        valign = 'center',
                        widget = wibox.widget.textbox
                    },
                    -- Subtext
                    wibox.widget{
                        markup = helpers.colorize_text(theme.profile.subtext.markup, theme.profile.subtext.color),
                        font = theme.profile.subtext.font .. " " .. theme.profile.subtext.font_size,
                        align  = 'center',
                        valign = 'center',
                        widget = wibox.widget.textbox
                    }
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
        border_width = theme.border.width,
        border_color = theme.border.color,
        widget = wibox.container.background()
    }


    -- ===================================================================
    -- functionality
    -- ===================================================================

    -- toggle panel
    local function toggle_panel(screen)
        if screen == s then
            menu_panel.visible = not menu_panel.visible
        end
    end

    -- connect panel toggle function to relevant signals
    awesome.connect_signal("menu::toggle", toggle_panel)

end

return panel
