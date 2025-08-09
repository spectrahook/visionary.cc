local fetch = {};

function fetch.load(url: string)
	local Attempt: number = 0;
	while Attempt < 3 do
		Attempt += 1;
		local success, result = pcall(function()
			return game:HttpGet(url);
		end)
		if success then
			loadstring(result)();
			return;
		end
		task.wait();
	end
	error('Games not found or failed to load after 3 attempts.');
end
