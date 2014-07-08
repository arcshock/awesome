--[[
-- Author: Bucky Frost
-- Date: Sun Dec 29 13:40:00 AKST 2013
-- File: init.lua
-- Purpose: list of programs to execute on Awesome WM startup
--]]

--{{{ Includes
local awful = require("awful")
--}}}

local Init_Module = {}

function Init_Module.start()
	awful.util.spawn_with_shell("run_once.sh xcompmgr -cF &")
	awful.util.spawn_with_shell("run_once.sh xscreensaver &")
	awful.util.spawn_with_shell("run_once.sh kmix")
end

return Init_Module
