-- If LuaRocks is installed, make sure that packages installed through it are found (e.g. lgi).
pcall(require, 'luarocks.loader')

local naughty    = require "naughty"
local beautiful  = require "beautiful"
local awful      = require "awful"
local gears      = require "gears"
local naughty    = require "naughty"

local config_path = gears.filesystem.get_configuration_dir()

-- ===================================================================
-- Default Applications
-- ===================================================================
Apps = {
    terminal = "kitty",
    launcher = "rofi -show drun -display-drun '>'",
    screenshot = "flameshot gui",
    file_manager = "thunar"
}

-- ===================================================================
-- Error Handling
-- ===================================================================

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err)
        }
        in_error = false
    end)
end

-- ===================================================================
-- Theme & Configuration
-- ===================================================================

local theme = "kafe"
beautiful.init(config_path .. "themes/" .. theme .. "/theme.lua")

local configuration = "kafe"
local active_configuration = require("configurations." .. configuration)
active_configuration.init()

-- ===================================================================
-- Keyboard Layout
-- ===================================================================

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

mykeyboardlayout:connect_signal("widget::layout_changed", function()
  naughty.notify {
      title = "Keyboard Layout",
      text = string.upper(
          mykeyboardlayout._layout[
              ( mykeyboardlayout._current )
              % #mykeyboardlayout._layout + 1
          ]
      ),
      timeout = 1
  }
end)

-- ===================================================================
-- Keybindings
-- ===================================================================

-- Set global key bindings
local globalkeys = require("keybindings")
root.keys(globalkeys)

-- ===================================================================
-- Rules
-- ===================================================================

-- Rules to apply to new clients (through the 'manage' signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = { },
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Tag rules
    { rule = { class = "discord"},
      properties = {screen = 3, tag = "1"}}
}

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position
    and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
    if c.maximized then
        awful.placement.maximize(c, {
            honor_padding = true,
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
end)



-- ===================================================================
-- UI
-- ===================================================================

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- ===================================================================
-- Autorun
-- ===================================================================

-- Run autorun script
awful.spawn.with_shell(config_path .. "autorun.sh")


-- ===================================================================
-- Screen Change Functions (ie multi monitor)
-- ===================================================================

-- Reload config when screen geometry changes
screen.connect_signal("property::geometry", awesome.restart)

-- ===================================================================
-- Garbage Collection
-- ===================================================================

collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
