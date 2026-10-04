
    -- Variables

-- All requirements
G.acad.GradeReq = {
	{
		grade = "A+",

		met = true,
		score = 5,
		hands = 1,
		discards = 1,
		points = 4
	},
	{
		grade = "A",

		met = true,
		score = 2,
		hands = 1,
		discards = 2,
		points = 3
	},
	{
		grade = "B+",

		met = true,
		score = 2,
		hands = 2,
		discards = 3,
		points = 1.5
	},
	{
		grade = "B",

		met = true,
		score = 1.5,
		hands = 2,
		discards = 4,
		points = 1
	},
	{
		grade = "C+",

		met = true,
		score = 1.2,
		hands = 3,
		discards = 10,
		points = 0.5
	},
	{
		grade = "C",

		met = true,
		score = 1,
		hands = 4,
		discards = 10,
		points = 0
	},
	{
		grade = "F",

		met = true,
		score = 1,
		hands = 10,
		discards = 10,
		points = -1 -- I can do minus values since it automatically gets set to 1 if below 1
	},
	{
		grade = "??",

		met = true,
		score = 0,
		hands = 10,
		discards = 10,
		points = -3 -- Bascially sets 1
	},
}

-- the different rewards with values
local GradeRewards = { -- Total == 1
	[1] = {
		title = "Random Joker",
		name = "R-joke",
		weight = 0.25,
	},
	[2] = {
		title = "Random Buff",
		name = "R-buff",
		weight = 0.25,
	},
	[3] = {
		title = "Random Tag",
		name = "R-tag",
		weight = 0.2,
	},
	[4] = {
		title = "Random Pack",
		name = "R-pack",
		weight = 0.1,
	},
	[5] = {
		title = "Random Voucher",
		name = "R-vouch",
		weight = 0.05,
	},
	[6] = {
		title = "nothing..",
		name = "air",
		weight = 0,
	},
} -- the numbers aren't required, I just wanna see the index of each reward

-- reward "Random Buff" needs to have a random buff.. heres the dif ones
local buffs = {
    {
        title = "+1 temporary hand",
		name = "R-buff",
        variable = "next_hands",
        change = 1
    },
    {
        title = "+1 temporary discard",
		name = "R-buff",
        variable = "discards",
        change = 1
    },
}

	-- Functions

local function Grade(ignoreScore) -- actually get the grade
	local discards = to_big(G.GAME.current_round.discards_used)
	local hands = to_big(G.GAME.current_round.hands_played)
	local required = to_big(G.GAME.blind.chips)
	local score = to_big(G.GAME.chips)
	local over = to_big(score / required)

	local hPoint = -4
	local gradetbl

	-- Check Score requirements
	for _, grade in ipairs(G.acad.GradeReq) do -- has to be ipairs puts it in order
        -- if overMagnitude is less than req, then false, added 'ignoreScore' for mid round calculating
		if not ignoreScore and over < to_big(grade.score) then grade.met = false end
		if ignoreScore and to_big(grade.score) > 1.5 then grade.met = false end

        -- if hands is less than req, then false
		if to_big(grade.hands) < hands then grade.met = false end

        -- if discards is less than req, then false
		if to_big(grade.discards) < discards then grade.met = false end

		if grade.met and (grade.points > hPoint) then
            hPoint = grade.points
            gradetbl = grade
		end
        -- Reset
		grade.met = true
	end

	return gradetbl or G.acad.GradeReq[#G.acad.GradeReq] -- gives lowest grade
end

function RandReward()
	local score = G.GAME.Grades

	if G.GAME.LastGrade.grade == "??" then
		return GradeRewards[#GradeRewards]
	end

-- set up copy
	local RewCopy = {}
	for i, v in pairs(GradeRewards) do
		if type(v) ~= "table" then
			RewCopy[i] = v
		else
			local table = {}
			for k, obj in pairs(v) do
				table[k] = obj -- will need another layer if i add some table in it
			end
			RewCopy[i] = table
		end
	end

-- Get the random
    local totalWeight = 0
	for i, reward in pairs(RewCopy) do
		reward.weight = reward.weight ^ (score ^ -1)
		-- say weight is 0.66 and score is 2.3, then its now 0.8347
        totalWeight = totalWeight + reward.weight
	end

    local randomNumber = math.random() * totalWeight

    local selectedIndex = nil
    for index, item in ipairs(RewCopy) do
        randomNumber = randomNumber - item.weight
        if randomNumber <= 0 then
            selectedIndex = index
            break
        end
    end

	return GradeRewards[selectedIndex]
end

-- get rewards, and give rewards
-- G.GAME.Grades is for the weighted random, meaning being better often rewards more
_acad.calculate = function(self, context)
	if context.setting_blind then                                                       -- i have no idea why we get grades like ts
		if G.GAME.Grades then
			G.GAME.Grades = G.GAME.Grades / 4 < 1 and 1 or G.GAME.Grades / 4
            -- if grade ÷ 4 iss less than 1, then be 1, if it isnt stay as grade ÷ 4
		else
			G.GAME.Grades = 1
		end
	elseif context.end_of_round and not context.game_over and context.main_eval then    -- Get a reward
		-- grades
		local grading = Grade()
		G.GAME.LastGrade = grading
		G.GAME.LastGradeVal = grading.grade
		G.GAME.Grades = G.GAME.Grades + grading.points * (G.GAME.GradeMult or 1)

		-- reward
		local reward = RandReward()
		if reward.name == "R-buff" then
			reward = buffs[math.random(1,#buffs)]
		end
		G.GAME.LG_Reward = reward
			--- Majority from vremade btwwww
	elseif context.starting_shop then                                                   -- Give reward
        -- Activate reward stuff
        -- vouchers are spawned, packs are spawned, etc etc

		local reward = G.GAME.LG_Reward

		if reward.name == "R-vouch" then
			local voucher_pool = get_current_pool('Voucher')
			local selected_voucher = pseudorandom_element(voucher_pool, 'acad_R_vouch')
			local it = 1
			while selected_voucher == 'UNAVAILABLE' do
				it = it + 1
				selected_voucher = pseudorandom_element(voucher_pool, 'acad_seed' .. it)
			end
			local voucher_card = SMODS.create_card({ area = G.play, key = selected_voucher }) -- Ignore the previous code and just use a key for a prefined voucher
			voucher_card:start_materialize()
			voucher_card.cost = 0
			G.play:emplace(voucher_card)
			delay(0.8)
			voucher_card:redeem()

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				func = function()
					voucher_card:start_dissolve()
					return true
				end
			}))
		elseif reward.name == "R-pack" then
			local lock = "R-pack-".. math.random()
			G.CONTROLLER.locks[lock] = true
			G.E_MANAGER:add_event(Event({
				func = function()
					local booster = SMODS.create_card { set = "Booster", area = G.play }
					booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
					booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
					booster.T.w = G.CARD_W * 1.27
					booster.T.h = G.CARD_H * 1.27
					booster.cost = 0
					booster.from_tag = false

					G.FUNCS.use_card({ config = { ref_table = booster } })
					booster:start_materialize()
					G.CONTROLLER.locks[lock] = nil
					return true
				end
			}))
		elseif reward.name == "R-tag" then
			local tag_pool = get_current_pool('Tag')
			local selected_tag = pseudorandom_element(tag_pool, 'acad_R_tag')
			local it = 1
			while selected_tag == 'UNAVAILABLE' do
				it = it + 1
				selected_tag = pseudorandom_element(tag_pool, 'acad_seed_resample'..it)
			end
			add_tag(Tag(selected_tag, false, 'Small')) -- Ignore the previous code and just use a key for a prefined tag
		elseif reward.name == "R-joke" and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			SMODS.add_card{ -- For a random one
				set = "Joker", -- You can use a custom pool/ObjectType. See `What's a pool/set?`
				key_append = "acad_append" -- Optional, key for randomization/pool checking
			}

	-- buffs
		elseif reward.name == "R-buff" then
			G.GAME.round_bonus[reward.variable] = G.GAME.round_bonus[reward.variable] + math.floor(reward.change + G.GAME.Grades / 3)
		end
	elseif context.setting_blind or context.discard or									-- Update text
	context.initial_scoring_step or context.after then
		local grading = Grade(true)
		G.GAME.LastGrade = grading
		G.GAME.LastGradeVal = grading.grade.. "~"									
	end
end