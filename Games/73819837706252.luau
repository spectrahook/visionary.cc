local _VNY = shared

local HttpService: HttpService = cloneref(game:GetService("HttpService"))
local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players: Players = cloneref(game:GetService("Players"))
local Workspace: Workspace = cloneref(game:GetService("Workspace"))
local Camera: Camera = Workspace.CurrentCamera

local LocalPlayer: Player = Players.LocalPlayer
local GameName: string = Import(_VNY.Modules .. "Misc/GameName.luau")
local RemoteEvent: RemoteEvent = ReplicatedStorage.Modules.Utility.Network.Events.RemoteEvent
local RemoteFunction: RemoteFunction = ReplicatedStorage.Modules.Utility.Network.Functions.RemoteFunction

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
	AutoReel = false,
	AutoSell = false
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

local InventoryTab = Window:Tab({
	Title = "Inventory",
	Icon = "backpack"
})

local FavoriteSection = InventoryTab:Section({
	Title = "Favorite",
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
		RemoteFunction:InvokeServer("SellInventory", nil, Workspace:GetServerTimeNow())
	end
})

ShopTab:Button({
	Title = "Sell Holding Fish",
	Desc = "",
	Locked = false,
	Callback = function()
		local Tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
		if Tool then
			RemoteFunction:InvokeServer("SellHoldingFish", nil, Workspace:GetServerTimeNow())
		end
	end
})

ShopTab:Toggle({
	Title = "Auto Sell Inventory",
	Type = "Checkbox",
	Default = Settings.AutoSell,
	Callback = function(Value)
		Settings.AutoSell = Value
	end
})

task.spawn(function()
	while task.wait(1) do
		if Settings.AutoSell then
			RemoteFunction:InvokeServer("SellInventory", nil, Workspace:GetServerTimeNow())
		end
	end
end)

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
	local Args = { ... }
	if Settings.AutoPerfect
		and tostring(Self) == "RemoteEvent"
		and Args[1] == "RodActivated"
		and type(Args[2]) == "table" then
		Args[2].LuckMulti = 99999
		return OldNamecall(Self, unpack(Args))
	end
	return OldNamecall(Self, ...)
end)

task.spawn(function()
	while task.wait() do
		if Settings.AutoReel then
			RemoteEvent:FireServer("GotFish", nil, Workspace:GetServerTimeNow())
		end
		if Settings.AutoCast then
			RemoteEvent:FireServer(
				"RodActivated",
				{
					LuckMulti = 99999,
					Mouse = {
						Target = Workspace.World.Map.Holder.Water,
						Hit = CFrame.new(Camera.CFrame.Position)
					}
				},
				Workspace:GetServerTimeNow()
			)
		end
	end
end)

local AutoFavorite: boolean = false
local FavoriteBy: { string } = { "Rarity" }
local SelectedRarities: { string } = { "Legendary" }
local MinWeight: number = 35

InventoryTab:Button({
	Title = "Favorite All",
	Desc = "",
	Locked = false,
	Callback = function()
		for _, Item in next, LocalPlayer.Backpack:GetChildren() do
			RemoteEvent:FireServer(
				"FavouriteItem",
				{ Item = Item, Favourited = true },
				Workspace:GetServerTimeNow()
			)
		end
	end
})

InventoryTab:Button({
	Title = "Unfavorite All",
	Desc = "",
	Locked = false,
	Callback = function()
		for _, Item in next, LocalPlayer.Backpack:GetChildren() do
			RemoteEvent:FireServer(
				"FavouriteItem",
				{ Item = Item, Favourited = false },
				Workspace:GetServerTimeNow()
			)
		end
	end
})

InventoryTab:Toggle({
	Title = "Auto Favorite",
	Type = "Checkbox",
	Default = false,
	Callback = function(Value)
		AutoFavorite = Value
	end
})

InventoryTab:Dropdown({
	Title = "Favorite by",
	Values = { "Rarity", "Weight" },
	Value = { "Rarity" },
	Multi = true,
	AllowNone = true,
	Callback = function(Option)
		FavoriteBy = Option
	end
})

InventoryTab:Dropdown({
	Title = "Pick Rarities",
	Values = { "Uncommon", "Common", "Rare", "Epic", "Legendary", "Mythical" },
	Value = { "Legendary" },
	Multi = true,
	AllowNone = true,
	Callback = function(Option)
		SelectedRarities = Option
	end
})

InventoryTab:Input({
	Title = "Put Weight",
	Value = "35",
	InputIcon = "weight",
	Type = "Input",
	Callback = function(Input)
		MinWeight = tonumber(Input) or 0
	end
})

RemoteEvent.OnClientEvent:Connect(function(EventName, Data)
	if not AutoFavorite then
		return
	end

	if EventName == "FishOnHook" and type(Data) == "table" then
		local Pass = false

		if table.find(FavoriteBy, "Rarity") and table.find(SelectedRarities, Data.Rarity) then
			Pass = true
		end

		if table.find(FavoriteBy, "Weight") and tonumber(Data.Weight) and Data.Weight >= MinWeight then
			Pass = true
		end

		if Pass then
			for _, Item in next, LocalPlayer.Backpack:GetChildren() do
				if string.find(Item.Name, Data.Name) then
					RemoteEvent:FireServer(
						"FavouriteItem",
						{ Item = Item, Favourited = true },
						Workspace:GetServerTimeNow()
					)
				end
			end
		end
	end
end)
