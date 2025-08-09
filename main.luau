local GameList = {
	PrisonPump = {
		PlaceId = 80279663815725;
	};
};

local PlaceId: number = game.PlaceId;
local Repository: string = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/';
local Games: string = Repository .. 'Games/';

for _, data in pairs(GameList) do
	if PlaceId == data.PlaceId then
		fetch.load(Games .. data.PlaceId .. '.luau');
		break;
	end
end
