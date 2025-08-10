local _VNY = shared

local Services = Import(_VNY.Modules .. 'Misc/Services.luau')
local Players: Players = Services.Players
local Workspace: Workspace = Services.Workspace
local MarketplaceService: MarketplaceService = Services.MarketplaceService
local LocalPlayer: Player = Players.LocalPlayer;
local PlayerGui: PlayerGui = LocalPlayer.PlayerGui;

local FightClick: ImageButton = PlayerGui.FightUI.PrisonFight.BG.TapButton;
local WorkoutClick: ImageButton = PlayerGui.WorkoutOverlay.BG.TapButton;

local WorkoutModule = require(Workspace.Src.WorkoutHandler);
local OldStamina = WorkoutModule.ReachedZeroStamina;

local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua'))();
WindUI.TransparencyValue = 0.8;
WindUI:SetTheme('Indigo')

local Window = WindUI:CreateWindow({
    Title = 'Visionary.cc - Prison Pump',
    Icon = '',
    Size = UDim2.fromOffset(400, 250),
    Theme = 'Indigo'
});

local Main = Window:Section({ Title = 'Farming', Opened = true });
local Clicking = Main:Tab({ Title = 'Clicking', Icon = 'mouse-pointer-click' });

local Misc = Window:Section({ Title = 'Misc', Opened = true });
local Vuln = Misc:Tab({ Title = 'Vulnerability', Icon = 'wrench' });

local Settings = {
    Clicking = {
        Fight = false;
        Workout = false;
    };
    Vulnerability = {
        InfiniteStamina = false;
    };
};

Clicking:Toggle({
    Title = 'Auto Fight';
    Value = false;
    Callback = function(state)
        Settings.Clicking.Fight = state;
    end;
});

Clicking:Toggle({
    Title = 'Auto Workout';
    Value = false;
    Callback = function(state)
        Settings.Clicking.Workout = state;
    end;
});

Vuln:Toggle({
    Title = 'Infinite Stamina';
    Value = false;
    Callback = function(state)
            hookfunction(WorkoutModule.ReachedZeroStamina, function(...)
                return nil
            end)      
    end
});

task.spawn(function()
    while task.wait() do
        if Settings.Clicking.Fight and FightClick.Visible then
            firesignal(FightClick.Activated);
        end;
        if Settings.Clicking.Workout and WorkoutClick.Visible then
            firesignal(WorkoutClick.Activated);
        end;
    end;
end);
