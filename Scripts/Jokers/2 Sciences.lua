                                    ---- Sciences ----

            -- Biology --

-- Adaptation | to be fixed
SMODS.Joker {
    key = "adapt",

    rarity = 2,
    cost = 5,

    blueprint_compat = true,
    config = { 
        extra = {
            mult = 5,
            xmult = 1.1,
        }
    },
    attributes = {'mult', 'scaling'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.xmult}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_bio'), G.C.GOLD, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        elseif context.after and not SMODS.last_hand_oneshot and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.xmult
                end,
                message = localize("k_upgrade_ex")
            }
        end
    end
}

-- Mutualism
SMODS.Joker {
    key = "mutual",
	atlas = 'JokerAtlas',
	pos = { x = 2, y = 0 },

    rarity = 2,
    cost = 3,


    blueprint_compat = true,
    config = { 
        extra = {
            dollars = 1,
            sell_value = 1,
        }
    },
    attributes = {'position', 'economy'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.dollars}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_bio'), G.C.GOLD, G.C.WHITE, 1 )
        badges[#badges+1] = create_badge("Art by Le ginger", G.C.UI.TEXT_INACTIVE, G.C.WHITE, .8)
    end,

    calculate = function(self, card, context)
        if context.post_trigger then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            if other_joker and context.other_card == other_joker then
                if other_joker.set_cost then
                    other_joker.ability.extra_value = (other_joker.ability.extra_value or 0) +
                    card.ability.extra.sell_value
                    other_joker:set_cost()
                end
                return {
                    message_card = card,
                    dollars = card.ability.extra.dollars,
                    extra = {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                }
            end
        end
    end
}

-- Commensalism | to be tested
SMODS.Joker {
    key = "commen",

    rarity = 2,
    cost = 3,

    blueprint_compat = true,
    config = { 
        extra = {
            dollars = 3,
        }
    },
    attributes = {'position', 'economy'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.dollars}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_bio'), G.C.GOLD, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.post_trigger then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            if context.other_card == other_joker then
                return {
                    dollars = card.ability.extra.dollars,
                }
            end
        end
    end
}

--[[ Parasitism | to be tested
local scoring_Values = { 
    'mult_mod', 'chips_mod', 
    'mult', 'chips', 'score',
    'xmult', 'xchips', 'xscore',
    'repetitions', 'dollars', 'swap',
    'balance', 'level_up',
    "playing_cards_created", -- DNA
}
local misc_Values = {
    'text_colour', 'font', -- ?? | doesnt have colour or message as that gets replaced
    'sound', 'pitch', 'volume',
    'func', 'pre_func', -- might remove later
    'no_juice',
    'saved' -- haha
}
local all_values = {table.unpack(scoring_Values), table.unpack(misc_Values)}

SMODS.Joker {
    key = "parasite",

    rarity = 3,
    cost = 6,

    blueprint_compat = false,
    config = { 
        extra = {
            dollars = 4,
        }
    },
    attributes = {'position', 'economy'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.dollars}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_bio'), G.C.GOLD, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.post_trigger and not context.blueprint then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            
            if context.other_card == other_joker then
                local check = false
                for ix, v in pairs(context.other_ret.jokers) do
                    print("checking ", ix)
                    if btrFunctions.tblfind(scoring_Values, ix) then
                        print(ix, " found in checks")
                        check = true
                        break
                    end
                end
                if check then
                    print(tprint(context.other_ret.jokers))
                    for ix, v in pairs(context.other_ret.jokers) do
                        print("checking ", ix)
                        if btrFunctions.tblfind(all_values, ix) then
                            print(ix, " found in checks")
                            v = nil
                        end
                    end
                    if context.other_ret.jokers.extra then
                        for ix, v in pairs(context.other_ret.jokers.extra) do
                            if btrFunctions.tblfind(all_values, ix) then
                                v = nil
                            end
                        end
                    end

                    context.other_ret.jokers['message'] = localize('k_cancelled')
                    context.other_ret.jokers['colour'] = G.C.RED
                    context.other_ret.jokers['card'] = nil
                    print(tprint(context.other_ret.jokers))
                    return {
                        dollars = card.ability.extra.dollars,
                        message = "$4",
                        colour = G.C.MONEY,
                        message_card = card,
                        remove_default_message = true,
                    }
                else
                    return {
                        message = "Invalid!",
                        colour = G.C.RED,
                    }
                end
            end
        end
    end
}]]

-- Death Spiral | to be tested
SMODS.Joker {
    key = "deathspiral",

    rarity = 1,
    cost = 3,

    blueprint_compat = true,
    config = { 
        extra = {
            mult = 0,
            add = 1,
        }
    },
    attributes = {'mult', 'scaling'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.add}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_bio'), G.C.GOLD, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play and next(context.poker_hands['Pair']) then
            return {
                func = function()
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                end,
                message = localize("k_upgrade_ex")
            }
        elseif context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

            -- Astronomy --

--Astrophysicist | to be tested
SMODS.Joker {
    key = "astrophys",

    rarity = 3,
    cost = 6,

    attributes = {'space', 'joker', 'generation'},
    blueprint_compat = false,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_astro'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            -- #vremade riff_raff
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            key_append = 'vremade_astrophys',
                            attributes = {'space'}
                        }
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,
}

-- redshift hook
local get_chip_bonus_ref = Card.get_chip_bonus
function Card:get_chip_bonus()
    local ret = get_chip_bonus_ref(self)

    if SMODS.find_card('j_acad_redshift') and
    not SMODS.has_playing_card_property(self, 'replace_base_card') and
    self.RedShift then
        ret = 0
    end

    return ret
end

-- redshift joker 
SMODS.Joker {
    key = "redshift",

    rarity = 2,
    cost = 5,

    attributes = {'mult', 'space', 'position', 'rank'},
    blueprint_compat = true,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_astro'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.before then
            context.scoring_hand[#context.scoring_hand].RedShift = true
        elseif context.individual and context.cardarea == G.play and
        context.other_card == context.scoring_hand[#context.scoring_hand] then
            -- body
            return {
                mult =  context.other_card.base.nominal +
                        context.other_card.ability.bonus +
                        (context.other_card.ability.perma_bonus or 0)
            }
        elseif context.after then
            context.scoring_hand[#context.scoring_hand].RedShift = true
        end
    end
}

-- Equinox | idea by JakeUpsy
SMODS.Joker {
    key = "equinox",

    rarity = 3,
    cost = 8,

    blueprint_compat = false,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_astro'), G.C.PURPLE, G.C.WHITE, 1 )
        badges[#badges+1] = create_badge("By JakeUpsy", G.C.UI.TEXT_INACTIVE, G.C.WHITE, .8)
    end,

    attributes = {'balance', 'space'},
    calculate = function(self, card, context) -- easiest joker ever
        if context.initial_scoring_step then
            return {
                balance = true
            }
        end
    end
}

-- The Big Bang | unfinished | to be tested
SMODS.Joker {
    key = "bang",

    rarity = 4,
    cost = 15,

    attributes = {'mult', 'space'},
    blueprint_compat = false,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_astro'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    add_to_deck = function(self, card, from_debuff)
        if from_debuff then return end
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
    end,

    can_sell = function(self, card, context)
        if G.GAME.blind.in_blind then
            return false
        end
        return true
    end,

    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        blockable = false,
                        no_delete = true,
                        func = function()
                            G.GAME.skips = 0
                            G.GAME.bosses_used = {}
                            G.GAME.round = 1
                            G.GAME.won = false
                            ease_ante(1)
                            G.GAME.blind:set_blind(G.P_BLINDS.bl_small)
                            return true
                        end
                    }))
                end
            }
        end
    end
}