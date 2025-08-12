local _VNY = shared
-- read the license
local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players: Players = cloneref(game:GetService("Players"))
local Workspace: Workspace = cloneref(game:GetService("Workspace"))

local LocalPlayer: Player = Players.LocalPlayer
local GameName: string = Import(_VNY.Modules .. "Misc/GameName.luau")
local RemoteEvent: RemoteEvent = ReplicatedStorage.Modules.Utility.Network.Events.RemoteEvent

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
WindUI.TransparencyValue = 0.8
WindUI:SetTheme("Indigo")

local Window = WindUI:CreateWindow({
    Title = "Visionary.cc - " .. GameName,
    Icon = "home",
    Size = UDim2.fromOffset(400, 250),
    Theme = "Indigo"
})

local Settings = {
    AutoCast = false,
    AutoPerfect = true,
    AutoReel = false
}

local FarmingTab = Window:Tab({
    Title = "Farming",
    Icon = "waves"
})

local FishingSection = FarmingTab:Section({
    Title = "Fishing",
    TextXAlignment = "Left",
    TextSize = 17
})

local ShopTab = Window:Tab({
    Title = "Shop",
    Icon = "shopping-bag"
})

local SellSection = ShopTab:Section({
    Title = "Sell",
    TextXAlignment = "Left",
    TextSize = 17
})

Window:SelectTab(1)

FarmingTab:Toggle({
    Title = "Auto Perfect",
    Type = "Checkbox",
    Default = Settings.AutoPerfect,
    Callback = function(Value)
        Settings.AutoPerfect = Value
    end
})

FarmingTab:Toggle({
    Title = "Auto Cast",
    Type = "Checkbox",
    Default = Settings.AutoCast,
    Callback = function(Value)
        Settings.AutoCast = Value
    end
})

FarmingTab:Toggle({
    Title = "Instant Reel",
    Type = "Checkbox",
    Default = Settings.AutoReel,
    Callback = function(Value)
        Settings.AutoReel = Value
    end
})

ShopTab:Button({
    Title = "Sell Your Inventory",
    Desc = "",
    Locked = false,
    Callback = function()
        RemoteEvent:InvokeServer("SellInventory", Workspace:GetServerTimeNow())
    end
})

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Arguments = { ... }
    if Settings.AutoPerfect
    and tostring(Self) == "RemoteEvent"
    and Arguments[1] == "RodActivated"
    and type(Arguments[2]) == "table" then -- idk why i use newline
        Arguments[2].LuckMulti = 100
        return OldNamecall(Self, unpack(Arguments))
    end
    return OldNamecall(Self, ...)
end)

task.spawn(function()
    while task.wait() do
        if Settings.AutoReel then
            RemoteEvent:FireServer("GotFish", nil, Workspace:GetServerTimeNow())
        end
        if Settings.AutoCast then
            local Camera = Workspace.CurrentCamera
            local TargetCFrame = CFrame.new(Camera.CFrame.Position + Camera.CFrame.LookVector * 10)
            RemoteEvent:FireServer("RodActivated", {
                LuckMulti = 100,
                Mouse = {
                    Target = Workspace.World.Map.Holder.Water,
                    Hit = TargetCFrame
                }
            }, Workspace:GetServerTimeNow())
        end
    end
end)
