local Recipes = loadstring(game:HttpGet("https://raw.githubusercontent.com/spectrahook/visionary.cc/refs/heads/main/Modules/GrowAGarden/Foods.luau",true))()
local FoodHelper = {}
function FoodHelper.GetIngredients(FoodName: string, Rarity: string): { [string]: number }?
	local Data = Recipes.Food[FoodName]
	return if Data then Data[Rarity] else nil
end

function FoodHelper.GetRarities(FoodName: string): { string }?
	local Data = Recipes.Food[FoodName]
	if not Data then return nil end
	local Rarities = {}
	for Rarity in pairs(Data) do
		table.insert(Rarities, Rarity)
	end
	return Rarities
end

return FoodHelper
