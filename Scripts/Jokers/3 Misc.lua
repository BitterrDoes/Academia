--[[IQ Test
SMODS.Joker {
    key = "iqtest",

    rarity = 2,
    cost = 6,

    blueprint_compat = true,
    config = { 
        extra = {
            mult = 0,
            add = 4,
            hit = false,
            pleasetrigger = false
        }
    },
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.add}}
	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        elseif context.post_joker and not context.blueprint then
            G.QTE_ResetVars("j_acad_iqtest")
            card.ability.extra.pleasetrigger = false
        end
    end
}--]]
                                    ---- Humanities ----

            -- Philosophy --

