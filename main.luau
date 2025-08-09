local GameList = {
	PrisonPump = {
		PlaceId = 80279663815725;
	};
}

local PlaceId: number = game.PlaceId
local Repository: string = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/'
local Games: string = Repository .. 'Games/'
local Library: string = Repository .. 'Library/'

local Libraries = {}
local function import(LibName: string)
	if not Libraries[LibName] then
		local src = game:HttpGet(Repository .. LibName, true)
		Libraries[LibName] = loadstring(src)()
	end
	return Libraries[LibName]
end

local fetch = import("{Library}httpfetch.luau')

for _, data in pairs(GameList) do
	if PlaceId == data.PlaceId then
		fetch.load(Games .. data.PlaceId .. '.luau')
		break
	end
end
