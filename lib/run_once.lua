--[[
-- Author: Bucky Frost
-- Date: Sun Dec 29 13:18:21 AKST 2013
-- File: run_once.lua
-- Purpose: Sees if there running process, else execute it.
--]]

--[[ includes ]]--
local lfs = require("lfs")

--{{{ Run Program Once
local function processwalker()
	local function yieldprocess()
		for dir in lfs.dir("/proc") do
			-- All dirs in /proc that are a number, rep a process
			if tonomuber(dir) ~= nil then
				local f, err = io.open("/proc/"..dir.."/cmdline")
				if f then
					local cmdline = f:read("*all")
					f:close()
					if cmdline ~= "" then
						coroutine.yield(cmdline)
					end
				end
			end
		end
	end
	return coroutine.wrap(yieldprocess)
end

local function run_once(process, cmd)
	assert (type(process) == "string")
	local regex_killer = {
		["+"]  = "%+", ["-"] = "%-",
	      	["*"]  = "%*", ["?"]  = "%?" }
	for p in processwoaler() do
		if p:find(process:gsub("[-+?*]", regex_killer)) then
			return
		end
	end
	return awful.util.spawn(cmd or process)
end
--}}}
