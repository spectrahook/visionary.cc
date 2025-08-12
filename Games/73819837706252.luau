local _VNY = shared
local WindUI = fetch.load("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
local Modules = Import(_VNY.Modules .. "FishGo/Modules.luau")
local Services = Import(_VNY.Modules .. "Misc/Services.luau")
local GameName = Import(_VNY.Modules .. "Misc/GameName.luau")

local Window = WindUI:CreateWindow({
	Title = "Visionary.cc - " .. GameName,
	Icon = "door-open",
	Author = "liebertsx",
	Folder = "Visionary.cc",
	Size = UDim2.fromOffset(580, 460),
	Transparent = true,
	Theme = "Dark",
	Resizable = true,
	SideBarWidth = 200,
	ScrollBarEnabled = true,
	User = {
		Enabled = true,
		Anonymous = true,
		Callback = function()
			print("clicked")
		end
	}
})

local Settings = {
	AutoCast = false,
	AutoPerfect = true,
	AutoReel = false
}

local Farming = Window:Tab({
	Title = "Farming",
	Icon = "waves",
	Locked = false
})

Window:SelectTab(1)

local Fishing = Farming:Section({
	Title = "Fishing",
	TextXAlignment = "Left",
	TextSize = 17
})

local AutoPerfect = Farming:Toggle({
	Title = "Auto Perfect",
	Desc = "",
	Type = "Checkbox",
	Default = Settings.AutoPerfect,
	Callback = function(v)
		Settings.AutoPerfect = v
	end
})

local AutoCast = Farming:Toggle({
	Title = "Auto Cast",
	Desc = "",
	Type = "Checkbox",
	Default = Settings.AutoCast,
	Callback = function(v)
		Settings.AutoCast = v
	end
})

local InstantReel = Farming:Toggle({
	Title = "Instant Reel",
	Desc = "",
	Type = "Checkbox",
	Default = Settings.AutoReel,
	Callback = function(v)
		Settings.AutoReel = v
	end
})

local Old
Old = hookmetamethod(game, "__namecall", function(Self, ...)
	local Arguments = { ... }
	if Settings.AutoPerfect and tostring(Self) == "RemoteEvent" and Arguments[1] == "RodActivated" and type(Arguments[2]) == "table" then
		Arguments[2].LuckMulti = 100
		return Old(Self, unpack(Arguments))
	end
	return Old(Self, ...)
end)

Modules:Connect(function(...)
	local Arguments = { ... }
	if Settings.AutoReel and Arguments[1] == "FishOnHook" then
		Modules:Fire("GotFish", nil, workspace:GetServerTimeNow())
	end
end)

task.spawn(function()
	while task.wait() do
		if Settings.AutoCast then
			Modules:Fire("RodActivated", { LuckMulti = 100, Mouse = { Target = workspace.World.Map.Holder.Water, Hit = CFrame.new(-608.821533203125, 444.0174560546875, -167.37042236328125) * CFrame.Angles(-2.5284948348999023, -0.15726494789123535, -3.031848669052124) } }, workspace:GetServerTimeNow())
		end
	end
end)
