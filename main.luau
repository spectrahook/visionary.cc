local _VNY = shared

_VNY.Repository = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/'
_VNY.Library = _VNY.Repository .. 'Library/'
_VNY.Games = _VNY.Repository .. 'Games/'
_VNY.Modules = _VNY.Repository .. 'Modules/'

local GameList = {
	PrisonPump = {
		PlaceId = 80279663815725;
	},
	['Poop A Brainrot'] = {
		PlaceId = 82321750197896;
	}
}

local PlaceId: number = game.PlaceId

local Libraries = {}

function Import(url: string)
	if Libraries[url] then
		return Libraries[url]
	end

	local attempts = 0
	while attempts < 3 do
		attempts += 1
		local success, result = pcall(game.HttpGet, game, url, true)
		if success and result then
			local fn, err = loadstring(result)
			if fn then
				local ok, module = pcall(fn)
				if ok then
					Libraries[url] = module
					return module
				else
					error(tostring(module))
				end
			else
				error(tostring(err))
			end
		end
		task.wait()
	end

	error("failed to load module from " .. url .. " after 3 attempts")
end

local fetch = Import(_VNY.Library .. 'httpfetch.luau')

for _, v in pairs(GameList) do
	if PlaceId == v.PlaceId then
		fetch.load(_VNY.Games .. v.PlaceId .. '.luau')
		break
	end
end
