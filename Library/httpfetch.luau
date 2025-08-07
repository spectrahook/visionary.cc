local HttpFetcher = {}
do
	local HttpService = cloneref(game:GetService("HttpService"))
	local Workspace = cloneref(game:GetService("Workspace"))

	local InternalCache = setmetatable({}, {
		__index = function(_, k)
			error("Missing cache key: " .. tostring(k), 2)
		end,
		__newindex = function(_, k, v)
			rawset(InternalCache, k, v)
		end
	})

	local _ENV = getgenv and getgenv() or getrenv and getrenv() or getfenv and getfenv() or {}

	local Urls: { [string]: string } = {}
	Urls.Owner = "https://raw.githubusercontent.com/spectrahook/"
	Urls.Repository = Urls.Owner .. "visionary.cc/refs/heads/main/"
	Urls.Games = Urls.Repository .. "Games/"
	Urls.Modules = Urls.Repository .. "Modules/"
	Urls.Library = Urls.Repository .. "Library/"

	local function FormatUrl(url: string): string
		for key, path in Urls do
			url = url:gsub("{" .. key .. "}", path)
		end
		return url
	end

	local function IdentifyExecutor(): string
		return typeof(identifyexecutor) == "function" and identifyexecutor() or "Unknown"
	end

	local function ShowError(text: string)
		if _ENV.error_message then
			_ENV.error_message:Destroy()
		end

		local Message = Instance.new("Message", Workspace)
		Message.Text = string.gsub(text, Urls.Owner, "")
		_ENV.error_message = Message

		error(text, 2)
	end

	local function DetectRequest(): (({Url: string, Method: string, Headers: {}, Body: string}) -> {Success: boolean, StatusCode: number, Body: string})?
		local req = (syn and syn.request)
			or (http and http.request)
			or (http_request)
			or (request)

		if typeof(req) == "function" then
			return req
		end
		return nil
	end

	local RawRequest = DetectRequest()

	function HttpFetcher:Get(url: string): string
		url = FormatUrl(url)
		local success, result = pcall(function()
			if game.HttpGet then
				return game:HttpGet(url)
			elseif RawRequest then
				local r = RawRequest({ Url = url, Method = "GET" })
				if r and r.Success then return r.Body end
				error(r and r.Body or "Unknown error")
			else
				error("No supported HTTP method")
			end
		end)

		if success then
			return result
		else
			ShowError(`[1] [{IdentifyExecutor()}] failed to get URL: {url}\n>> {result} <<`)
		end
	end

	function HttpFetcher:Load(url: string, extra: string?): () -> ...any
		local source = self:Get(url) .. (extra or "")
		local func, err = loadstring(source)

		if not func then
			ShowError(`[2] [{IdentifyExecutor()}] syntax error loading: {url}\n>> {err} <<`)
		end

		return func
	end

	function HttpFetcher:QueueTeleport(url: string, ...)
		local queue = queue_on_teleport or (syn and syn.queue_on_teleport)
		if typeof(queue) == "function" and not _ENV.added_teleport_queue then
			_ENV.added_teleport_queue = true

			local encoded = ""
			local ok, packed = pcall(function()
				return HttpService:JSONEncode({ ... })
			end)
			if ok then
				encoded = `unpack(game:GetService("HttpService"):JSONDecode('{packed}'))`
			end

			local code = `loadstring(game:HttpGet('{FormatUrl(url)}'))({encoded})`
			pcall(queue, code)
		end
	end

	function HttpFetcher:ClearCache()
		table.clear(InternalCache)
	end

	function HttpFetcher:GetUrls(): {}
		return Urls
	end

	setmetatable(HttpFetcher, {
		__index = HttpFetcher,
		__newindex = function(_, k)
			error("Attempt to write HttpFetcher property: " .. tostring(k), 2)
		end
	})
end

return HttpFetcher
