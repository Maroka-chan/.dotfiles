local ez            = require "lib.awesome-ez"
local awful         = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local gears         = require "gears"
local naughty       = require "naughty"

local config_path   = gears.filesystem.get_configuration_dir()

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()


clientkeys = ez.keytable {
    ["M-f"] = { function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    { description = "Toggle fullscreen", group = "client" }},
    ["M-S-q"]       = { function (c) c:kill() end,
    { description = "Close client", group = "client" }},
    ["M-C-space"]   = { awful.client.floating.toggle, 
    { description = "Toggle floating", group = "client" }},
    ["M-C-Return"]  = { function (c) c:swap(awful.client.getmaster()) end,
    { description = "Move to master", group = "client" }},
    ["M-o"]         = { function (c) c:move_to_screen() end,
    { description = "Move to screen", group = "client" }},
    ["M-C-t"]       = { function (c) c.ontop = not c.ontop end,
    { description = "Toggle keep on top", group = "client" }},
    ["M-n"]         = { function (c) c.minimized = true end,
    { description = "Minimize client", group = "client" }},
    ["M-m"]         = { function (c)
        c.maximized = not c.maximized
        c:raise()
    end,
    { description = "(un)maximize client", group = "client" }},
    ["M-C-m"]       = { function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end,
    { description = "(un)maximize client vertically", group = "client" }},
    ["M-S-m"]       = { function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end,
    { description = "(un)maximize client horizontally", group = "client" }},
    ["M-Tab"]       = { function (c)
        c:emit_signal("sidepanel::toggle", c)
    end,
    { description = "Toggle sidepanel", group = "client" }}
}

clientbuttons = ez.btntable {
    ["1"]           = function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end,
    ["M-1"]         = function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end,
    ["M-3"]         = function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end
}

local globalkeys    = ez.keytable {
    ["M-d"]         = { function () awful.spawn(Apps.launcher) end,
    { description = "Show Rofi", group = "app" }},
    ["M-S-."]       = { function () awful.spawn(config_path .. "lib/splatmoji/splatmoji -j type") end,
    { description = "Show Rofimoji", group = "app" }},
    ["M-b"]         = { function () awful.spawn("firefox") end,
    { description = "Open Firefox", group = "app" }},
    ["Print"]       = { function () awful.spawn("flameshot full -c") end,
    { description = "Fullscreen screenshot", group = "screenshot" }},
    ["M-S-s"]       = { function () awful.spawn("flameshot gui") end,
    { description = "Selection screenshot", group = "screenshot" }},
    ["M-S-space"]   = { function ()
        mykeyboardlayout.next_layout()
        naughty.notify {
            title = "Keyboard Layout",
            text = string.upper(
                mykeyboardlayout._layout[
                    ( mykeyboardlayout._current + 1 )
                    % #mykeyboardlayout._layout + 1
                ]
            ),
            timeout = 1
        }
    end,
    { description = "Change keyboard layout", group = "utility" }},
    ["M-F1"]        = { hotkeys_popup.show_help,
    { description = "Show help", group = "awesome" }},
    ["M-C-Left"]    = { awful.tag.viewprev,
    { description = "View previous tag", group = "tag" }},
    ["M-C-Right"]   = { awful.tag.viewnext,
    { description = "View next tag", group = "tag" }},
    ["M-Left"]      = { function () awful.client.focus.byidx(1) end,
    { description = "Focus next tag by index", group = "client" }},
    ["M-Right"]     = { function () awful.client.focus.byidx(-1) end,
    { description = "Focus previous tag by index", group = "client" }},
    ["M-S-Left"]    = { function () awful.client.swap.byidx(1) end,
    { description = "Swap with next client by index", group = "client" }},
    ["M-S-Right"]   = { function () awful.client.swap.byidx(-1) end,
    { description = "Swap with previous client by index", group = "client" }},
    ["M-A-Right"]   = { function () awful.screen.focus_relative(1) end,
    { description = "Focus the next screen", group = "screen" }},
    ["M-A-Left"]    = { function () awful.screen.focus_relative(-1) end,
    { description = "Focus the previous screen", group = "screen" }},
    ["M-u"]         = { awful.client.urgent.jumpto,
    { description = "Jump to urgent client", group = "client" }},
    ["M-Return"]    = { function () awful.spawn('kitty') end,
    { description = "Open a terminal", group = "launcher" }},
    ["M-S-r"]       = { function ()
        local file, err = io.open(config_path .. "reload.lck", "w")
        if not file then
            naughty.notify {
                preset = naughty.config.presets.critical,
                title = 'Oops, an error happened!',
                text = tostring(err)
            }
            return
        end
        file:write("reloading awesome...")
        file:close()
        awesome.restart()
    end,
    { description = "Reload AwesomeWM", group = "awesome" }},
    ["M-C-n"]       = { function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end,
    { description = "Restore minimized client", group = "client" }}
}


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    table.insert(globalkeys, ez.key("M-#" .. i + 9,
        { function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end,
        { description = "View tag #" .. i, group = "tag" }})
    )
    table.insert(globalkeys, ez.key("M-C-#" .. i + 9,
        { function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
        { description = "Toggle tag #" .. i, group = "tag" }})
    )
    table.insert(globalkeys, ez.key("M-S-#" .. i + 9,
        { function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        { description = "Move focused client to tag #" .. i, group = "tag" }})
    )
    table.insert(globalkeys, ez.key("M-C-S-#" .. i + 9,
        { function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = "Toggle focused client on tag #" .. i, group = "tag" }})
    )
end

return globalkeys
