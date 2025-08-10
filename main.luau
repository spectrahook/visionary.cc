local GameList: {[string]: { PlaceId: number }} = {
    PrisonPump = {
        PlaceId = 80279663815725,
    },
    ['Fish It'] = {
        PlaceId = 121864768012064,
    }
}

local PlaceId: number = game.PlaceId
local Repository: string = 'https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/'
local Games: string = Repository .. 'Games/'
local Library: string = Repository .. 'Library/'

local Libraries: {[string]: any} = {}

local function Import(url: string): any
    if not Libraries[url] then
        local src: string = game:HttpGet(url, true)
        local loadedFunc, loadError = load(src)
        if loadedFunc then
            Libraries[url] = loadedFunc()
        else
            error(("Failed to load module from %s: %s"):format(url, loadError))
        end
    end
    return Libraries[url]
end

local fetch = Import(Library .. 'httpfetch.luau')

for _, v in pairs(GameList) do
    if PlaceId == v.PlaceId then
        fetch.load(Games .. tostring(v.PlaceId) .. '.luau')
        break
    end
end
