local awful     = require "awful"
local helpers   = require "helpers"
local beautiful = require "beautiful"
local wibox     = require "wibox"
local dpi       = beautiful.dpi
local theme     = beautiful.widgets.weather
local naughty   = require "naughty"

-- List of weather codes https://api.met.no/weatherapi/weathericon/2.0/documentation
local weather = {
    clearsky = {
        text = "Clear Sky",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    cloudy = {
        text = "Cloudy",
        icon = ""
    },
    partlycloudy = {
        text = "Partly Cloudy",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    fair = {
        text = "Fair",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    fog = {
        text = "Fog",
        icon = ""
    },


    --Rain
    rain = {
        text = "Rain",
        icon = ""
    },
    rainandthunder = {
        text = "Rain and Thunder",
        icon = ""
    },
    rainshowers = {
        text = "Rain Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    rainshowersandthunder = {
        text = "Rain Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Heavy Rain
    heavyrain = {
        text = "Heavy Rain",
        icon = ""
    },
    heavyrainandthunder = {
        text = "Heavy Rain\nand Thunder",
        icon = ""
    },
    heavyrainshowers = {
        text = "Heavy Rain Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    heavyrainshowersandthunder = {
        text = "Heavy Rain Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Sleet
    sleet = {
        text = "Sleet",
        icon = ""
    },
    sleetandthunder = {
        text = "Sleet\nand Thunder",
        icon = ""
    },
    sleetshowers = {
        text = "Sleet Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    sleetshowersandthunder = {
        text = "Sleet Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Heavy Sleet
    heavysleet = {
        text = "Heavy Sleet",
        icon = ""
    },
    heavysleetandthunder = {
        text = "Heavy Sleet\nand Thunder",
        icon = ""
    },
    heavysleetshowers = {
        text = "Heavy Sleet Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    heavysleetshowersandthunder = {
        text = "Heavy Sleet Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Snow
    snow = {
        text = "Snow",
        icon = ""
    },
    snowandthunder = {
        text = "Snow\nand Thunder",
        icon = ""
    },
    snowshowers = {
        text = "Snow Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    snowshowersandthunder = {
        text = "Snow Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Heavy Snow
    heavysnow = {
        text = "Heavy Snow",
        icon = ""
    },
    heavysnowandthunder = {
        text = "Heavy Snow\nand Thunder",
        icon = ""
    },
    heavysnowshowers = {
        text = "Heavy Snow Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    heavysnowshowersandthunder = {
        text = "Heavy Snow Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Light Rain
    lightrain = {
        text = "Light Rain",
        icon = ""
    },
    lightrainandthunder = {
        text = "Light Rain\nand Thunder",
        icon = "ﭼ"
    },
    lightrainshowers = {
        text = "Light Rain Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    lightrainshowersandthunder = {
        text = "Light Rain Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Light Sleet
    lightsleet = {
        text = "Light Sleet",
        icon = ""
    },
    lightsleetandthunder = {
        text = "Light Sleet\nand Thunder",
        icon = ""
    },
    lightsleetshowers = {
        text = "Light Sleet Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    lightssleetshowersandthunder = {
        text = "Light Snow Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },

    -- Light Snow
    lightsnow = {
        text = "Light Snow",
        icon = ""
    },
    lightsnowandthunder = {
        text = "Light Snow\nand Thunder",
        icon = ""
    },
    lightsnowshowers = {
        text = "Light Snow Showers",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    },
    lightssnowshowersandthunder = {
        text = "Light Snow Showers\nand Thunder",
        icon = {
            day = "",
            night = "",
            polartwilight = ""
        }
    }
}

local icon = wibox.widget {
    font = theme.icon_font .. " " .. theme.icon_size,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local temp = wibox.widget {
    font = theme.font .. " " .. theme.font_size,
    align = 'left',
    valign = 'center',
    widget = wibox.widget.textbox
}

local weather_text = wibox.widget {
    font = theme.font .. " " .. theme.font_size,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local widget = wibox.widget {
    nil,
    {
        icon,
        {
            temp,
            weather_text,
            layout = wibox.layout.fixed.vertical
        },
        spacing = dpi(20),
        layout = wibox.layout.fixed.horizontal
    },
    expand = "outside",
    layout = wibox.layout.align.horizontal
}

local updated_at = nil
awesome.connect_signal("menu::toggle", function ()
    local current_hour = os.date("*t").hour
    if updated_at == current_hour then return end

    awful.spawn.easy_async_with_shell("curl -s 'https://api.met.no/weatherapi/locationforecast/2.0/compact?altitude=" .. theme.altitude .. "&lat=" .. theme.lat .. "&lon=" .. theme.lon .. "' | jq '.\"properties\".\"timeseries\"[0].\"data\"'", function (weather_data)
        awful.spawn.easy_async_with_shell("echo '" .. weather_data .. "' | jq '.\"instant\".\"details\".\"air_temperature\"'", function (temperature)
            awful.spawn.easy_async_with_shell("echo '" .. weather_data .. "' | jq '.\"next_1_hours\".\"summary\".\"symbol_code\"'", function (weather_summary)
                local summary = helpers.split(string.sub(weather_summary, 2, -3), "_")

                local current_weather = weather[summary[1]]
                local weather_icon = ""
                if #(summary) > 1 then weather_icon = current_weather.icon[summary[2]] else weather_icon = current_weather.icon end

                icon:set_markup_silently(helpers.colorize_text(weather_icon, theme.color))
                temp:set_markup_silently(helpers.colorize_text(string.sub(temperature, 0, -2) .. " 糖", theme.color))
                weather_text:set_markup_silently(helpers.colorize_text(current_weather.text, theme.color))
                updated_at = current_hour
            end)
        end)
    end)
end)


return widget