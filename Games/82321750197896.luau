local _VNY = shared

local Services = Import(_VNY.Modules .. "Misc/Services.luau")
local GameName = Import(_VNY.Modules .. "Misc/GameName.luau")

if Services and GameName then
    print("[Visionary.cc] All modules have loaded successfully")
else
    warn("[Visionary.cc] Modules failed to load")
end

local Players: Players = Services.Players
local ReplicatedStorage: ReplicatedStorage = Services.ReplicatedStorage

local LocalPlayer: Player = Players.LocalPlayer
local PlayerGui: PlayerGui = LocalPlayer.PlayerGui

local PoopUI: ScreenGui = PlayerGui.PoopUI
local Cursor: Frame = PoopUI.PoopAreaCursor.PoopCursor
local Area: Frame = PoopUI.PoopBar.PoopArea

local Tap: RemoteEvent = ReplicatedStorage.TapButtonTappedEvent
local BigPoop: RemoteEvent = ReplicatedStorage.BigPoopAnimation

local Settings = { Minigame = false; Notify = false }

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
WindUI.TransparencyValue = 0.8
WindUI:SetTheme("Indigo")

local Window = WindUI:CreateWindow({ Title = "Visionary.cc - " .. GameName, Icon = "home", Size = UDim2.fromOffset(400, 250), Theme = "Indigo" })
local Main = Window:Section({ Title = "Farming", Opened = true })
local Pooping = Main:Tab({ Title = "Pooping", Icon = "mouse-pointer-click" })

Pooping:Toggle({
    Title = "Auto Minigame";
    Value = false;
    Callback = function(state)
        Settings.Minigame = state
        if state then
            repeat
                Area.Position = UDim2.new(Cursor.Position.X.Scale, Area.Position.X.Offset, Area.Position.Y.Scale, Area.Position.Y.Offset)
                Tap:Fire()
                task.wait()
            until not Settings.Minigame
        end
    end
})

Pooping:Toggle({
    Title = "Notify Big Poop";
    Value = false;
    Callback = function(state)
        Settings.Notify = state
    end
})

BigPoop.OnClientEvent:Connect(function()
    if Settings.Notify then
        WindUI:Notify({ Title = "INFORMATION", Content = "You got big poop", Image = "bell" })
    end
end)
