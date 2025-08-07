
local Scripts = {
	{
		PlacesIds = {126884695634066};
		UrlPath = "GrowAGarden.luau";
	};
}

local fetcher, urls = {}, {}
local _ENV = (getgenv or getrenv or getfenv)()

urls.Owner = "https://raw.githubusercontent.com/spectrahook/visionary.cc/"
urls.Repository = urls.Owner .. "main/"
urls.Modules = urls.Repository .. "Modules/"
urls.Library = urls.Repository .. "Library/"

do
	local last = _ENV.__visionary_debounce
	if last and tick() - last < 5 then
		return nil
	end
	_ENV.__visionary_debounce = tick()
end

do
	local ex = syn or fluxus
	local queue = queue_on_teleport or (ex and ex.queue_on_teleport)
	if not _ENV.__visionary_tp and typeof(queue) == "function" then
		local args = {...}
		local json = ""
		local ok, data = pcall(function()
			return game:GetService("HttpService"):JSONEncode(args)
		end)
		if ok and data then
			json = "unpack(game:GetService('HttpService'):JSONDecode('" .. data .. "'))"
		end
		_ENV.__visionary_tp = true
		pcall(queue, ("loadstring(game:HttpGet('%smain.luau'))(%s)"):format(urls.Repository, json))
	end
end

do
	local function fail(msg)
		local m = Instance.new("Message", workspace)
		m.Text = msg
		_ENV.__visionary_error = m
		error(msg, 2)
	end

	local function resolve(url)
		for k, v in urls do
			url = url:gsub("{" .. k .. "}", v)
		end
		return url
	end

	function fetcher.get(url)
		local ok, res = pcall(function()
			return game:HttpGet(resolve(url))
		end)
		if ok then
			return res
		else
			fail(res)
		end
	end

	function fetcher.load(url: string, concat: string?)
		local raw = fetcher.get(url) .. (concat or "")
		local fn, err = loadstring(raw)
		if typeof(fn) ~= "function" then
			fail(err)
		end
		return fn
	end
end

local function match(script)
	return table.find(script.PlacesIds or {}, game.PlaceId)
end

for _, script in Scripts do
	if match(script) then
		return fetcher.load("{Repository}Games/" .. script.UrlPath)(fetcher, ...)
	end
end
