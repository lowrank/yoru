local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local widgets = require("ui.widgets")

return function(s)

    local task_list_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus or c.minimized == false then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end),
        awful.button({}, 3, function()
            awful.menu.client_list({theme = {width = 250}})
        end),
        awful.button({}, 4, function()
            awful.client.focus.byidx(1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx(-1)
        end)
    )

    s.bottom_tasklist = awful.widget.tasklist({
            screen = s,
            filter = awful.widget.tasklist.filter.currenttags,

            layout = {
                layout = wibox.layout.fixed.horizontal,
            },
            buttons = task_list_buttons,
        })

    s.bottom_panel =  awful.wibar({
        position = "bottom",
        screen = s,
        border_width = 0,
        height = 24,
        bg = beautiful.wibar_bg,
        fg = beautiful.wibar_fg,
        widget = {
            {
                {
                    layout = wibox.layout.align.horizontal,
                    {
                        layout = wibox.layout.fixed.horizontal,
                    },
                    s.bottom_tasklist,
                    {
                        layout = wibox.layout.align.horizontal,
                    }
                },
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin,
            },
            bg = beautiful.wibar_bg,
            widget = wibox.container.background,
        },
    })

end