local awful      = require "awful"
local wibox      = require "wibox"
local beautiful  = require "beautiful"
local helpers    = require "helpers"
local xresources = require "beautiful.xresources"
local dpi        = xresources.apply_dpi
local theme      = beautiful.widgets.taglist

local taglist = {}


-- Button Functions
local tag_buttons = awful.util.table.join(
    -- Left click - View clicked tag
    awful.button({}, 1,
            function(t)
                t:view_only()
            end
    ),

    -- Right click - Add tag to viewed tags
    awful.button({}, 3,
            function(t)
                awful.tag.viewtoggle(t)
            end
    ),

    -- Scroll up - View tail tag
    awful.button({}, 4,
            function(t)
                awful.tag.viewprev(t.screen)
            end
    ),

    -- Scroll down - View head tag
    awful.button({}, 5,
            function(t)
                awful.tag.viewnext(t.screen)
            end
    )
)


-- Set tag properties
local list_create = function(widget, tag, index, tags)
    local tag_text = widget:get_children_by_id("index_role")[1]
    
    tag_text.font = theme.font .. " " .. theme.font_size
    -- Force width so that glyphs of different width always take up the same space in the taglist
    tag_text.forced_width = dpi(25)
    tag_text.align = 'center'
    tag_text.valign = 'center'
end


-- Update tag markup text
local list_update = function(widget, tag, index, tags)
    local tag_text = widget:get_children_by_id("index_role")[1]
    if tag.selected then
        tag_text.markup = helpers.colorize_text(
            theme.text.selected,
            theme.colors.selected
        )
    elseif tag.urgent then
        tag_text.markup = helpers.colorize_text(
            theme.text.urgent,
            theme.colors.urgent
        )
    elseif #tag:clients() > 0 then
        tag_text.markup = helpers.colorize_text(
            theme.text.occupied,
            theme.colors.occupied
        )
    else
        tag_text.markup = helpers.colorize_text(
            theme.text.empty,
            theme.colors.empty
        )
    end
end


-- Create the tag list widget
taglist.create = function(s)
    return awful.widget.taglist{
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout  = {
            spacing = theme.spacing,
            layout = wibox.layout.fixed.vertical,
        },
        buttons = tag_buttons,
        widget_template = {
            {
                id     = "index_role",
                widget = wibox.widget.textbox,
            },
            widget = wibox.container.background,
            create_callback = list_create,
            update_callback = list_update
        }
    }
end

return taglist
