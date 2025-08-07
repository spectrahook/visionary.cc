local Recipes = {}
local Food: { [string]: { [string]: { [string]: number } } } = {
		['Soup'] = {
			['Very Common'] = {
				['Carrot'] = 1,
			},
			['Uncommon'] = {
				['Green Apple'] = 1,
				['Grape'] = 1,
			},
			['Rare'] = {
				['Coconut'] = 1,
				['Elder Strawberry'] = 1,
			},
		},

		['Salad'] = {
			['Common'] = {
				['Bamboo'] = 1,
				['Carrot'] = 3,
			},
			['Rare'] = {
				['Orange Tulip'] = 1,
				['Bamboo'] = 1,
				['Carrot'] = 1,
				['Tomato'] = 1,
			},
			['Legendary'] = {
				['Blood Banana'] = 2,
				['Tomato'] = 2,
			},
			['Mythical'] = {
				['Tomato'] = 1,
				['Pepper'] = 2,
			},
			['Divine'] = {
				['Sugar Apple'] = 4,
				['Tomato'] = 1,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 4,
				['Tomato'] = 1,
			},
		},

		['Cake'] = {
			['Common'] = {
				['Strawberry'] = 1,
				['Tomato'] = 1,
				['Corn'] = 1,
				['Apple'] = 1,
			},
			['Rare'] = {
				['Watermelon'] = 2,
				['Corn'] = 2,
			},
			['Legendary'] = {
				['Banana'] = 2,
				['Blood Banana'] = 1,
				['Moon Melon'] = 1,
				['Soft Sunshine'] = 1,
			},
			['Mythical'] = {
				['Lucky Bamboo'] = 1,
				['Sugar Apple'] = 3,
				['Corn'] = 1,
			},
			['Divine'] = {
				['Corn'] = 1,
				['Elder Strawberry'] = 2,
				['Sugar Apple'] = 2,
			},
			['Prismatic'] = {
				['Banana'] = 1,
				['Bone Blossom'] = 3,
			},
		},

		['Donut'] = {
			['Rare'] = {
				['Corn'] = 2,
				['Tomato'] = 1,
				['Banana'] = 1,
			},
			['Legendary'] = {
				['Corn'] = 1,
				['Serenity'] = 1,
				['Sugar Apple'] = 1,
			},
			['Mythical'] = {
				['Corn'] = 1,
				['Sugar Apple'] = 1,
			},
			['Divine'] = {
				['Sugarglaze'] = 1,
				['Sugar Apple'] = 2,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 4,
				['Sugarglaze'] = 1,
			},
		},

		['Sandwich'] = {
			['Common'] = {
				['Tomato'] = 2,
				['Corn'] = 1,
			},
			['Legendary'] = {
				['Tomato'] = 2,
				['Beanstalk'] = 2,
				['Corn'] = 1,
			},
			['Mythical'] = {
				['Tomato'] = 1,
				['Corn'] = 1,
				['Elder Strawberry'] = 1,
			},
			['Divine'] = {
				['Bone Blossom'] = 3,
				['Tomato'] = 1,
				['Corn'] = 1,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 3,
				['Tomato'] = 1,
				['Violet Corn'] = 1,
			},
		},

		['Pie'] = {
			['Rare'] = {
				['Crown Melon'] = 1,
				['Jalapeno'] = 1,
			},
			['Legendary'] = {
				['Pumpkin'] = 1,
				['Apple'] = 1,
			},
			['Mythical'] = {
				['Sugar Apple'] = 1,
				['Pumpkin'] = 1,
			},
			['Divine'] = {
				['Coconut'] = 1,
				['Beanstalk'] = 1,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 4,
				['Pumpkin'] = 1,
			},
		},

		['Burger'] = {
			['Rare'] = {
				['Pepper'] = 1,
				['Corn'] = 1,
				['Tomato'] = 1,
				['Mint'] = 1,
			},
			['Legendary'] = {
				['Corn'] = 1,
				['Tomato'] = 2,
				['Ember Lily'] = 2,
			},
			['Mythical'] = {
				['Pepper'] = 1,
				['Corn'] = 1,
				['Tomato'] = 1,
				['Bone Blossom'] = 1,
			},
			['Divine'] = {
				['Corn'] = 1,
				['Tomato'] = 1,
				['Bone Blossom'] = 3,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 3,
				['Tomato'] = 1,
				['Corn'] = 1,
			},
		},

		['Hot Dog'] = {
			['Legendary'] = {
				['Pepper'] = 1,
				['Corn'] = 1,
			},
			['Mythical'] = {
				['Pepper'] = 2,
				['Corn'] = 1,
			},
			['Divine'] = {
				['Ember Lily'] = 4,
				['Corn'] = 1,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 4,
				['Corn'] = 1,
			},
		},

		['Waffle'] = {
			['Rare'] = {
				['Strawberry'] = 1,
				['Coconut'] = 1,
			},
			['Legendary'] = {
				['Coconut'] = 1,
				['Maple Apple'] = 1,
				['Banana'] = 3,
			},
			['Mythical'] = {
				['Tranquil Bloom'] = 1,
				['Starfruit'] = 1,
				['Coconut'] = 1,
			},
			['Divine'] = {
				['Sugar Apple'] = 1,
				['Coconut'] = 1,
			},
			['Prismatic'] = {
				['Bone Blossom'] = 3,
				['Sugar Apple'] = 1,
				['Coconut'] = 1,
			},
		},

		['Ice Cream'] = {
			['Rare'] = {
				['Watermelon'] = 1,
				['Corn'] = 1,
			},
			['Legendary'] = {
				['Banana'] = 1,
				['Watermelon'] = 1,
			},
			['Mythical'] = {
				['Banana'] = 1,
				['Sugar Apple'] = 1,
			},
			['Divine'] = {
				['Sugar Apple'] = 1,
				['Sugarglaze'] = 1,
			},
			['Prismatic'] = {
				['Sugar Apple'] = 1,
				['Sugarglaze'] = 1,
				['Bone Blossom'] = 3,
			},
		},

		['Sushi'] = {
			['Common'] = {
				['Bamboo'] = 4,
				['Corn'] = 1,
			},
			['Rare'] = {
				['Bamboo'] = 1,
				['Corn'] = 2,
				['Spike Mango'] = 1,
			},
			['Legendary'] = {
				['Bamboo'] = 3,
				['Corn'] = 1,
				['Maple Apple'] = 1,
			},
			['Mythical'] = {
				['Bamboo'] = 2,
				['Corn'] = 1,
				['Bone Blossom'] = 2,
			},
			['Divine'] = {
				['Bamboo'] = 1,
				['Corn'] = 1,
				['Bone Blossom'] = 3,
			},
		},

		['Pizza'] = {
			['Common'] = {
				['Strawberry'] = 1,
				['Pepper'] = 1,
				['Tomato'] = 1,
				['Corn'] = 1,
			},
			['Legendary'] = {
				['Corn'] = 1,
				['Tomato'] = 1,
				['Pepper'] = 1,
				['Sugar Apple'] = 1,
			},
			['Mythical'] = {
				['Pepper'] = 1,
				['Tomato'] = 1,
				['Sugar Apple'] = 1,
				['Corn'] = 1,
			},
			['Divine'] = {
				['Sugar Apple'] = 1,
				['Corn'] = 1,
				['Bone Blossom'] = 1,
			},
			['Prismatic'] = {
				['Banana'] = 1,
				['Beanstalk'] = 1,
				['Bone Blossom'] = 3,
			},
		},
	}

Recipes['Food'] = Food
return Recipes
