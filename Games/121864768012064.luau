local Services = Import(Modules .. 'Misc/Services.luau')
local Animation = Import(Modules .. 'Misc/AnimationController.luau')
local Players = Services.Players
local LocalPlayer = Player.LocalPlayer

while task.wait() do
if Animation:GetAnimation() == 'rbxassetid://180435571' then
game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_net@0.2.0").net:FindFirstChild("RE/FishingCompleted"):FireServer()
end
end
