
local fetch = {}

function fetch.load(url: string)
	local Attempt: number = 0
	while Attempt < 3 do
		Attempt += 1
		local success, result = pcall(function()
			return game:HttpGet(url, true)
		end)
		if success then
			local fn, err = loadstring(result)
			if not fn then
				error('Loadstring error: ' .. tostring(err))
			end
			fn()
			return
		end
		task.wait() -- uhh idk
	end
	error('Fetch failed after 3 attempts: ' .. url)
end

return fetch
