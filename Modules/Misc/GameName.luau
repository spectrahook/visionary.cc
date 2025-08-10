local _VNY: table = shared;
local Services: table = Import(_VNY.Modules .. "Misc/Services.luau")

return Services.MarketplaceService:GetProductInfo(game.PlaceId).Name
