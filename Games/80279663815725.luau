local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Services = Import(Modules .. 'Misc/Services.luau')

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
    Background = "", -- rbxassetid only
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

local Click = Tab:Section({ 
    Title = "Clicking",
    TextXAlignment = "Left",
    TextSize = 17, -- Default Size
})

local Workout = Main:Toggle({
    Title = "Auto Workout",
  --  Desc = "Toggle Description",
  --  Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        Config.Clicking.Workout = state
    end
})

local Fight = Main:Toggle({
    Title = "Auto Fight",
  --  Desc = "Toggle Description",
  --  Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        Config.Clicking.Fight = state
    end
})
