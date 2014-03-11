--[[
-- Author: Bucky Frost
-- Date: Sun Dec 29 13:40:00 AKST 2013
-- File: init.lua
-- Purpose: list of programs to execute on Awesome WM startup
--]]

--[[ includes ]]--
local awful = require("awful")
--local init = {}

--{{{ Local init function
function programs()
	awful.util.spawn_with_shell("run_once.sh xcompmgr -cF &")
	awful.util.spawn_with_shell("run_once.sh xscreensaver &")
	awful.util.spawn_with_shell("run_once.sh kmix")
end
--}}}
