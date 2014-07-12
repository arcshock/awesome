beautiful = require("beautiful")


--{{{ Variable definitions
CONFIG_DIR = "/home/voot/.config/awesome/"
package.path = "/home/voot/.config/awesome/lib/?.lua;" .. package.path
terminal = "konsole" or "xterm"
editor = os.getenv("EDITOR") or "gvim" or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"


-- Themes define colours, icons, and wallpapers
beautiful.init(CONFIG_DIR .. "themes/zenburn/theme.lua") -- Should read in from file?
dnicon = wibox.widget.textbox()
upicon = wibox.widget.textbox()
dnicon.image = CONFIG_DIR .. "icons/icojoy/icons_9x9/png/red/normal/001_54.png"
upicon.image = CONFIG_DIR .. "icons/icojoy/icons_9x9/png/green/normal/001_56.png"
beautiful.widget_net = CONFIG_DIR .. "icons/icojoy/icons_9x9/png/red/normal/001_54.png"


--{{{ Wallpaper
if beautiful.wallpaper then
	for screen_index = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, screen_index, true)
	end
end
-- }}}
--{{ Table of layouts to cover with awful.layout.inc, order matters.
layouts = { awful.layout.suit.floating,	-- 1
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,					-- 5
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,							-- 10
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier }
-- }}}


-- {{{ Tags
tags = { 	
	names  = { "main", "⁂", "gimp", "✒", "☎","✉", "♫", "⚞☉⚟", "⚒" },
	layout = { 	
			layouts[6], 
			layouts[10], 
			layouts[1], 
			layouts[10], 
			layouts[4], 
			layouts[12], 
			layouts[10], 
			layouts[3], 
			layouts[8],
	} 
}


for screen_index = 1, screen.count() do
	tags[screen_index] = awful.tag(tags.names, screen_index, tags.layout) -- Each screen has its own tag table.
end
-- }}}


local awesome_menu = {
	{ "RTFM", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", awesome.quit }
}


local audio = {
	{ "player", "Clementine" }
}


local office = {
	{ "Libre Suite", "libreoffice --quickstart" }
}


local programs = { 
	{ "office", office },
	{ "audio", audio } 
}


local customization = { 
	{ "wallpaper", "nitrogen" },
	{ "appearance", "lxappearance" }
}


my_main_menu = awful.menu({ 
	items = { 
			{ "awesome", awesome_menu },
			{ "customization", customization },
			{ "programs", programs },
			{ "terminal", terminal },
			{ "lock", "xscreensaver-command -lock" },
			{ "screen off", "xset dpms force off" },
	}
})


my_launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = my_main_menu })

menubar.utils.terminal = terminal 
-- }}}
