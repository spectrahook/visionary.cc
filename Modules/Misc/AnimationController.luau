local Players: Players = cloneref(game:GetService("Players"));

local Module = {};

do
    local AnimationController = {};
    AnimationController.__index = AnimationController;

    function AnimationController.new(Player: Player)
        local self = setmetatable({}, AnimationController);

        self.Player = Player;
        self.Character = Player.Character;
        self.Humanoid = self.Character and self.Character:FindFirstChildOfClass("Humanoid");
        self.Fired = false;
        self.Connections = {};

        self:ConnectCharacter();

        return self;
    end

    function AnimationController:ConnectCharacter()
        table.insert(self.Connections, self.Player.CharacterAdded:Connect(function(Character: Model)
            self.Character = Character;
            self.Humanoid = Character:WaitForChild("Humanoid", 5);
            self.Fired = false;
        end));
    end

    function AnimationController:GetAnimation(): string?
        if not self.Humanoid then return nil end

        local Tracks: {AnimationTrack} = self.Humanoid:GetPlayingAnimationTracks();
        for _, Track in ipairs(Tracks) do
            if Track.Animation then
                local AnimId: string = Track.Animation.AnimationId;

                if not self.Fired then
                    self.Fired = true;
                    return AnimId;
                end
                return nil;
            end
        end

        self.Fired = false;
        return nil;
    end

    function AnimationController:Disconnect()
        for _, Connection in ipairs(self.Connections) do
            Connection:Disconnect();
        end
        self.Connections = {};
    end

    Module.AnimationController = AnimationController;
end

return Module;
