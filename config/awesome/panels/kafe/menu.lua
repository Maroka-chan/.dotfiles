local beautiful      = require "beautiful"
local wibox          = require "wibox"
local awful          = require "awful"
local helpers        = require "helpers"
local gears          = require "gears"
local rubato         = require "lib.rubato"
local theme          = beautiful.panels.menu
local dpi            = beautiful.dpi

local date_widget    = require "widgets.date"
local cpu_widget     = require "widgets.cpu"
local ram_widget     = require "widgets.ram"
local disk_widget    = require "widgets.disk"
local weather_widget = require "widgets.weather"

-- define module table
local panel = {}

-- ===================================================================
-- Panel Creation
-- ===================================================================

panel.create = function(s)

    local menu_panel = awful.wibox({
        screen = s,
        height = s.geometry.height,
        width = s.geometry.width,
        bg = "#000000" .. "bb",
        ontop = true,
        visible = false
    })

    menu_panel:setup {
        {
            {
                { -- First section
                    date_widget,
                    helpers.spacer(25, "vertical"),
                    { -- Profile section
                        helpers.mask_image(beautiful.pfp, gears.shape.circle, theme.profile.pfp_size, theme.profile.pfp_size),
                        helpers.spacer(20, "vertical"),
                        { -- Text section
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
                            },
                            layout = wibox.layout.flex.vertical,
                            forced_height = dpi(80)
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    layout = wibox.layout.fixed.vertical
                },
                { -- Second section
                    cpu_widget,
                    ram_widget,
                    disk_widget,
                    layout = wibox.layout.align.horizontal,
                    expand = "none"
                },
                { -- Third section
                    weather_widget,
                    layout = wibox.layout.fixed.vertical
                },
                layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.margin,
            margins = theme.padding
        },
        widget = wibox.container.background()
    }


    -- ===================================================================
    -- functionality
    -- ===================================================================

    local menu_active = false
    local selected_tags = {}

    local opacity_timed = rubato.timed {
      intro = 0,
      duration = 0.15,
      awestore_compat = true
    }

    opacity_timed:subscribe(function(pos)
        menu_panel.opacity = pos
    end)

    opacity_timed.started:subscribe(function()
        if not menu_active then return end

        menu_panel.visible = true

        for _, t in ipairs(s.selected_tags) do
            selected_tags[#selected_tags+1] = t
            t.selected = false
        end

        awesome.emit_signal("mainpanel::hide", s)
    end)

    opacity_timed.ended:subscribe(function()
        if menu_active then return end

        menu_panel.visible = false

        for _, t in ipairs(selected_tags) do
            t.selected = true
        end
        selected_tags = {}

        awesome.emit_signal("mainpanel::show", s)
    end)


    -- toggle panel
    local function toggle_panel(screen)
        if not (screen == s) then return end

        menu_active = not menu_active
        opacity_timed.target = helpers.bool_to_number(menu_active)
    end

    -- connect panel toggle function to relevant signals
    awesome.connect_signal("menu::toggle", toggle_panel)

end

return panel
