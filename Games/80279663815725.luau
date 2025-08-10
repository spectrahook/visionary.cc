-- PrisonPump.luau

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Modules: string = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/Modules/'
local Services = Import(Modules .. 'Misc/Services.luau')
print('[Visionary] All modules has loaded')

local Window = WindUI:CreateWindow({
	Title = "Visionary.cc | Prison Pump",
	Icon = "zap",
	Author = "liebertsx | discord @liebertsx",
	Folder = "Visionary.cc",
	Size = UDim2.fromOffset(580, 460),
	Transparent = true,
	Theme = "Indigo",
	Resizable = true,
	SideBarWidth = 300,
	Background = "",
	BackgroundImageTransparency = 0.42,
	HideSearchBar = true,
	ScrollBarEnabled = false,
	User = {
		Enabled = true,
		Anonymous = true,
		Callback = function()
			print("clicked")
		end,
	},
})

WindUI:SetTheme("Indigo")

local Main = Window:Tab({
	Title = "Main",
	Icon = "home",
	Locked = false,
})

local Click = Main:Section({
	Title = "Clicking",
	TextXAlignment = "Left",
	TextSize = 17,
})

local Config = {
	Clicking = {
		Workout = false,
		Fight = false,
	},
}

local Workout = Main:Toggle({
	Title = "Auto Workout",
	Desc = "Automatically perform workouts to gain strength.",
	Type = "Checkbox",
	Default = false,
	Callback = function(state: boolean)
		Config.Clicking.Workout = state
	end,
})

local Fight = Main:Toggle({
	Title = "Auto Fight",
	Desc = "Automatically engage in fights to level up.",
	Type = "Checkbox",
	Default = false,
	Callback = function(state: boolean)
		Config.Clicking.Fight = state
	end,
})
