local beautiful  = require "beautiful"
local gears      = require "gears"
local wibox      = require "wibox"

local helpers = {}

function helpers.rrect(radius)
    return function(c, width, height)
        gears.shape.rounded_rect(c, width, height, radius)
    end
end

function helpers.colorize_text(text, color)
    return '<span foreground="' .. color ..'">' .. text .. '</span>'
end

function helpers.set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

function helpers.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function helpers.mask_image(image, mask_shape, width, height)
    return wibox.widget {
        {
            forced_width = width,
            forced_height = height,
            downscale = true,
            halign = 'center',
            valign = 'center',
            image = image,
            widget = wibox.widget.imagebox
        },
        shape = mask_shape,
        widget = wibox.container.background
    }
end

return helpers
