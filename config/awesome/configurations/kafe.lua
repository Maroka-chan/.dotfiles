local awful = require "awful"

local kafe = {}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.corner.nw,
    awful.layout.suit.fair,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating
}

kafe.init = function()
    -- Import Panels
    local main_panel = require("panels.kafe.main")
    local overlay_sidepanel = require("panels.kafe.menu")

    -- Set up screens
    awful.screen.connect_for_each_screen(function(s)
        for i = 1, 9 do
            awful.tag.add(i, {
                screen = s,
                layout = awful.layout.layouts[1],
                selected = i == 1
            })
        end

        main_panel.create(s)
        overlay_sidepanel.create(s)
    end)
end

return kafe
