-- sadly being away from the main joker file will have this load after always
Spectrallib = Spectrallib or {}
    -- so i dont get warns for it not existing

-- Twin Paradox
SMODS.Joker {
    key = "twinpara",

    rarity = 2,
    cost = 5,

    blueprint_compat = true,
    config = { 
        extra = {
            xmult = 1.05
        }
    },
    attributes = {'mult', 'chips'},
	loc_vars = function(_,_, card)
		return { vars = {card.ability.extra.xmult}}
	end,
    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_acad_arith'), G.C.PURPLE, G.C.WHITE, 1 )
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            local Enhanced = {}
            for i, v in pairs(table.pack(table.unpack(G.deck.cards), table.unpack(G.discard.cards))) do
                if next(SMODS.get_enhancements(v)) then
                    table.insert(Enhanced, v)
                    Spectrallib.manipulate(v, {value = 1.05})
                end
            end
            if next(Enhanced) then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
    end
}