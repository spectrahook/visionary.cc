local Players               = game:GetService("Players");
local ReplicatedStorage    = game:GetService("ReplicatedStorage");
local Workspace            = game:GetService("Workspace");
local StarterGui           = game:GetService("StarterGui");
local StarterPack          = game:GetService("StarterPack");
local StarterPlayer        = game:GetService("StarterPlayer");
local ServerStorage        = game:GetService("ServerStorage");
local ServerScriptService  = game:GetService("ServerScriptService");
local Lighting             = game:GetService("Lighting");
local TweenService         = game:GetService("TweenService");
local SoundService         = game:GetService("SoundService");
local RunService           = game:GetService("RunService");
local HttpService          = game:GetService("HttpService");
local TeleportService      = game:GetService("TeleportService");
local UserInputService     = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local CollectionService    = game:GetService("CollectionService");
local Debris               = game:GetService("Debris");
local Chat                 = game:GetService("Chat");
local DataStoreService     = game:GetService("DataStoreService");
local TextService          = game:GetService("TextService");
local MarketplaceService   = game:GetService("MarketplaceService");
local ReplicatedFirst      = game:GetService("ReplicatedFirst");
local BadgeService         = game:GetService("BadgeService");
local GuiService           = game:GetService("GuiService");
local HapticService        = game:GetService("HapticService");
local LocalizationService  = game:GetService("LocalizationService");
local PathfindingService   = game:GetService("PathfindingService");
local PolicyService        = game:GetService("PolicyService");
local ProximityPromptService = game:GetService("ProximityPromptService");
local SocialService        = game:GetService("SocialService");
local Stats                = game:GetService("Stats");
local TestService          = game:GetService("TestService");
local VirtualInputManager  = game:GetService("VirtualInputManager");
local VRService            = game:GetService("VRService");
local Teams                = game:GetService("Teams");
local GamepadService       = game:GetService("GamepadService");
local MessagingService     = game:GetService("MessagingService");

local fetch = ...;

if typeof(fetch) ~= "table" and isfile and readfile and isfile("httpfetch.luau") then
    fetch = { load = loadstring(readfile("httpfetch.luau")) };
end;

local LocalPlayer = Players.LocalPlayer;
local Utility = fetch.load("{Modules}GrowAGarden/");

local Modules = {
    Manager = {
        Foods = fetch.load("{Utility}Foods.luau");
    };
    EventManager = {
        CookingEvent = {
            CravingFood = Workspace.Interaction.UpdateItems.CookingEvent.CookingEventModel.PigChefFolder.PigChef.Cravings.CravingThoughtBubblePart.CravingBillboard.BG.CravingTextLabel;
        };
    };
};
