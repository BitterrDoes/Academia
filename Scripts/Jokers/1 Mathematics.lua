                            ---- Mathematics ----

            -- Arithmetic --
-- Addition
SMODS.Joker {
    key = "add",
	atlas = 'JokerAtlas',
	pos = { x = 0, y = 0 },

    rarity = 1,
    cost = 3,

    blueprint_compat = true,
    config = { 
        extra = {
            chips = 90,
            mult = 3,
        }
    },
    attributes = {'mult', 'chips'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.chips, card.ability.extra.mult}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Subtraction
SMODS.Joker {
    key = "minus",
	atlas = 'JokerAtlas',
	pos = { x = 1, y = 0 },

    rarity = 1,
    cost = 4,

    blueprint_compat = true,
    config = { 
        extra = {
            chips = 150,
            mult = 5,
            dollars = 3,
        }
    },
    attributes = {'mult', 'chips', 'economy'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.dollars}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                chips = (hand_chips - card.ability.extra.chips > 0) and -card.ability.extra.chips or -hand_chips+1,
                mult = mult - card.ability.extra.mult > 0 and -card.ability.extra.mult or (-mult)+1,
                dollars = card.ability.extra.dollars
            }
        end
    end
}

-- Multiplication
SMODS.Joker {
    key = "times",

    rarity = 1,
    cost = 4,

    blueprint_compat = true,
    config = { 
        extra = {
            xchips = 1.2,
            xmult = 1.2,
        }
    },
    attributes = {'xmult', 'xchips'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.xchips, card.ability.extra.xmult}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                xchips = card.ability.extra.xchips,
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Divisison
SMODS.Joker {
    key = "div",

    rarity = 1,
    cost = 4,

    blueprint_compat = true,
    config = { 
        extra = {
            xmult = 0.8,
        }
    },
    attributes = {'xmult', 'xchips', 'economy'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.xmult}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            return {
                dollars = math.floor(mult * card.ability.extra.xmult / 8), -- taken mult / 8
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- Termial | to be tested
SMODS.Joker {
    key = "term",

    rarity = 3,
    cost = 7,

    attributes = {'mult', 'chips'},
    blueprint_compat = true,
	loc_vars = function(_,info_queue, card)
        info_queue[#info_queue+1] = { key = "acad_termial", set = "Other" }
        return {}
	end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                chips = (hand_chips * hand_chips+1) / 2,
                mult = (mult * mult+1) / 2
            }
        end
    end
}

--[[ Logarithm | to be tested | might change to mult = math.log(card.ability.extra.logx) / math.log(hand_chips)
SMODS.Joker {
    key = "log",

    rarity = 2,
    cost = 5,

    blueprint_compat = true,
    config = { 
        extra = {
            logx = 10,
        }
    },
	loc_vars = function(_,info_queue, card)
        info_queue[#info_queue+1] = { key = "acad_logarithm", set = "Other" }
		return { vars = {card.ability.extra.logx}}
	end,

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                mult = math.log(card.ability.extra.logx, mult)
            }
        elseif context.setting_blind and not context.blueprint then
            card.ability.extra.logx = math.random(3,12)
        end
    end
}--]]

            -- Algebra --

-- Like Terms | No code
SMODS.Joker {
    key = "liketerm",

    rarity = 3,
    cost = 9,

    blueprint_compat = false,
	loc_vars = function(_,_, card)
		return {}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_alge'), G.C.BLUE, G.C.WHITE, 1 )
    end,
}

            -- computer science --
-- Sort Algorithm
SMODS.Joker {
    key = "sort",
    rarity = 2,
    cost = 5,
    blueprint_compat = false,

    config = {extra = {
        cAlg = "Bubble",
        store_chips = 0, store_mult = 0,
        Algorithms = {"Bubble", "Heap", "Merge", "Quick"}
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.cAlg
            }
        }
    end,
    set_ability = function(self, card, initial)
        local v = card.ability.extra
        v.cAlg = v.Algorithms[math.random(0, #v.Algorithms)]
    end,

    calculate = function(self, card, context)
        local v = card.ability.extra
        if context.initial_scoring_step then
                local combinedNum = tonumber(tostring(hand_chips).. tostring(mult))
                print(combinedNum, " ".. hand_chips.. " | ".. mult)
                local newNum = 0
                if v.cAlg == "Bubble" then
                    newNum = academia.sort_bubble(combinedNum)
                elseif v.cAlg == "Heap" then
                    newNum = academia.sort_heap(combinedNum)
                elseif v.cAlg == "Merge" then
                    newNum = academia.sort_merge(combinedNum)
                elseif v.cAlg == "Quick" then
                    newNum = academia.sort_quick(combinedNum)
                end
                newNum = newNum or combinedNum

                local newChip, newMult = tonumber(string.sub( newNum, 0, string.len(tostring(hand_chips)) )), tonumber(string.sub( newNum, string.len(tostring(hand_chips)) + 1, string.len(newNum)))

            hand_chips = mod_chips(newChip)
            return {
                message = "Sorted Chips!",
                color = G.C.CHIPS,
                func = function()
                    mult = mod_mult(newMult)
                end,
                extra = { message = "Sorted Mult!", color = G.C.MULT, }
            }
        elseif context.after then
            v.cAlg = v.Algorithms[math.random(1, #v.Algorithms)]
            return {
                message = v.cAlg.. " sort!",
            }
        end
    end
}
