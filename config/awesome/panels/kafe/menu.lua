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
local clock_widget   = require "widgets.menu_clock"

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
            {
              date_widget,
              halign = "left",
              valign = "top",
              widget = wibox.container.place
            },
            nil,
            {
              { -- Column 1
                ram_widget,
                cpu_widget,
                nil,
                layout = wibox.layout.fixed.horizontal
              },
              halign = "left",
              valign = "bottom",
              widget = wibox.container.place
            },
            layout = wibox.layout.flex.vertical
          },
          {
            clock_widget,
            nil,
            nil,
            layout = wibox.layout.flex.vertical
          },
          {
            nil,
            nil,
            nil,
            layout = wibox.layout.flex.vertical
          },
          layout = wibox.layout.flex.horizontal
        },
        margins = dpi(15),
        widget = wibox.container.margin
    }


    -- ===================================================================
    -- functionality
    -- ===================================================================

    local menu_active = false
    local selected_tags = {}

    local opacity_timed = rubato.timed {
      intro = 0,
      duration = 0.2,
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
