local _VNY = shared

local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local GameName: string = Import(_VNY.Modules .. "Misc/GameName.luau")

local RemoteEvent: RemoteEvent = ReplicatedStorage.Modules.Utility.Network.Events.RemoteEvent

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
WindUI.TransparencyValue = 0.8
WindUI:SetTheme("Indigo")

local Window = WindUI:CreateWindow({ Title = "Visionary.cc - " .. GameName, Icon = "home", Size = UDim2.fromOffset(400, 250), Theme = "Indigo" })


local Settings = {
	AutoCast = false,
	AutoPerfect = true,
	AutoReel = false
}

local Farming = Window:Tab({ Title = "Farming", Icon = "waves" })
Window:SelectTab(1)
Farming:Toggle({ Title = "Auto Perfect",
		Type = "Checkbox",
		Default = Settings.AutoPerfect, 
		Callback = function(v) 
			Settings.AutoPerfect = v 
		end 
	})
Farming:Toggle({
		Title = "Auto Cast",
		Type = "Checkbox", 
		Default = Settings.AutoCast, 
		Callback = function(v) 
			Settings.AutoCast = v 
			end 
	})
Farming:Toggle({
		Title = "Instant Reel",
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

task.spawn(function()
	while task.wait() do
		if Settings.AutoReel then
			RemoteEvent:FireServer("GotFish", nil, workspace:GetServerTimeNow())
		end
		if Settings.AutoCast then
			RemoteEvent:FireServer("RodActivated", { LuckMulti = 100, Mouse = { Target = workspace.World.Map.Holder.Water, Hit = CFrame.new(-608.8215, 444.0174, -167.3704) * CFrame.Angles(-2.5285, -0.15726, -3.03184) } }, workspace:GetServerTimeNow())
		end
	end
end)
