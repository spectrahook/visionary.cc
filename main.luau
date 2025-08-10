local GameList = {
	PrisonPump = {
		PlaceId = 80279663815725;
	};
}

local PlaceId: number = game.PlaceId
local Repository: string = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/'
local Games: string = Repository .. 'Games/'
local Library: string = Repository .. 'Library/'
local Modules: string = Repository .. 'Modules/'

local Libraries = {}
function Import(url: string)
	if not Libraries[url] then
		local src = game:HttpGet(url, true)
		Libraries[url] = loadstring(src)()
	end
	return Libraries[url]
end

local fetch = Import(Library .. 'httpfetch.luau')

for _, v in pairs(GameList) do
	if PlaceId == v.PlaceId then
		fetch.load(Games .. v.PlaceId .. '.luau')
		break
	end
end
