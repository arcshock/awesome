--[[
--Author: Bucky Frost
--File: rc.lua
--Purpose: Awesome WM configureation file
]]--


--{{{ Includes
gears = require("gears")
awful = require("awful")
	awful.rules = require("awful.rules")
	awful.autofocus = require("awful.autofocus")
wibox = require("wibox")
vicious = require("vicious")
beautiful = require("beautiful")
naughty = require("naughty")
menubar = require("menubar")
var = require("var")
bashets = require("bashets")
keymap = require("keymap")
init = require("init")
rules = require("rules")
signals = require("signals")
--}}}


init.start()
--{{{ Bashets Config
bashets.set_script_path("/dev/shm/bashets/")
bashets.set_temporary_path("/dev/shm/tmp/")
--}}}


--{{{ Error handling
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
										title = "Way to go dumbass, errors during startup!",
										text = awesome.startup_errors })
end

do
	local in_error = false
		awesome.connect_signal("debug::error", function (err)
			if in_error then
				return end
			
			in_error = true

			naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
			in_error = false
		end)
end
-- }}}





--{{{ Bashets
---[[ Makes a progress bar of the battery charge
batw = awful.widget.progressbar()
batw:set_max_value(100)
batw:set_width(5)
batw:set_height(16)
batw:set_color('#31fff3')
batw:set_background_color('#000000')
batw:set_vertical(true)
bashets.register("/home/voot/.local/scripts/bashets/battery.sh", {widget = batw, update_time = 2, separator = " ", async = false, format = '$2'})
--]]

bashets.start()
--}}}

-- {{{ Wibox
-- Network usage widget
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 3)

-- Textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(my_launcher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(upicon)
    right_layout:add(netwidget)
    right_layout:add(dnicon)
    right_layout:add(mytextclock)
    right_layout:add(batw)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}



