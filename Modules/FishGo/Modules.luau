local ReplicatedStorage: ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Remote: RemoteEvent = ReplicatedStorage.Modules.Utility.Network.Events.RemoteEvent

local Module = {}

function Module.Fire(...)
    return Remote:FireServer(...)
end

function Module.Invoke(...)
    return Remote:InvokeServer(...)
end

function Module.Connect(callback: (...any) -> ())
    return Remote.OnClientEvent:Connect(callback)
end

return Module
