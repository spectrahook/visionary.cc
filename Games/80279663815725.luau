local Players: Players = cloneref(game:GetService('Players'));
local Workspace: Workspace = cloneref(game:GetService('Workspace'));
local MarketplaceService: MarketplaceService = cloneref(game:GetService('MarketplaceService'));
local Lighting = cloneref(game:GetService("Lighting"));
local LocalPlayer: Player = Players.LocalPlayer;
local PlayerGui: PlayerGui = LocalPlayer.PlayerGui;

local FightClick: ImageButton = PlayerGui.FightUI.PrisonFight.BG.TapButton;
local WorkoutClick: ImageButton = PlayerGui.WorkoutOverlay.BG.TapButton;

local WorkoutModule = require(Workspace.Src.WorkoutHandler);

local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua'))();
WindUI.TransparencyValue = 1;
WindUI:SetTheme('Dark');

local Window = WindUI:CreateWindow({
    Title = 'Visionary.cc | Prison Pump',
    Icon = '',
    Size = UDim2.fromOffset(400, 250),
    Theme = 'Dark'
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

local OldStamina = WorkoutModule.ReachedZeroStamina;

Clicking:Toggle({
    Title = 'Auto Fight';
    Value = false;
    Callback = function(state)
        Settings.Clicking.Fight = state;
    end
});

Clicking:Toggle({
    Title = 'Auto Workout';
    Value = false;
    Callback = function(state)
        Settings.Clicking.Workout = state;
    end
});

Vuln:Toggle({
    Title = 'Infinite Stamina';
    Value = false;
    Callback = function(state)
        Settings.Vulnerability.InfiniteStamina = state;
        if state then
            Lighting.ColorCorrection:Destroy()
            hookfunction(WorkoutModule.ReachedZeroStamina, function(...)
                return nil
            end)
        else
            hookfunction(WorkoutModule.ReachedZeroStamina, OldStamina)
        end
    end
});

task.spawn(function()
    while task.wait() do
        if Settings.Clicking.Fight and FightClick.Visible then
            firesignal(FightClick.Activated);
        end
        if Settings.Clicking.Workout and WorkoutClick.Visible then
            firesignal(WorkoutClick.Activated);
        end
    end
end)
