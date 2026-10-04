return {
    descriptions = {
        Back = {},
        Blind = {},
        Enhanced = {},
        Joker = {

    -- MATH

        -- Arithmetic
            j_acad_add = {
                name = "Addition",
                text = {
                    "{C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult",
                    "{C:inactive}(Effects final Chip and Mult count)"
                }
            },
            j_acad_minus = {
                name = "Subtraction",
                text = {
                    "{C:chips}-#1#{} Chips, {C:mult}-#2#{} Mult, Earn {C:money}$#3#{}",
                    "{C:inactive}(Effects final Chip and Mult count)"
                }
            },
            j_acad_times = {
                name = "Multiplication",
                text = {
                    "{X:chips,C:white}X#1#{} Chips, {X:mult,C:white}X#2#{} Mult",
                    "{C:inactive}(Effects final Chip and Mult count)"
                }
            },
            j_acad_div = {
                name = "Division",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Earn {C:money}eighth{} of lost {C:mult}mult",
                    "{C:inactive}(Effects final Mult count)"
                }
            },
            j_acad_term = {
                name = "Termial",
                text = {
                    "applies {C:attention}Termial{} function",
                    "to initial {C:chips}Chips{} and {C:mult}Mult"
                }
            },
            j_acad_log = {
                name = "Logarithm",
                text = {
                    "adds {C:attention}log#1#{}({C:mult}Mult{}) to",
                    "initial {C:mult}Mult{}",
                    "{C:inactive}(Log value changes every blind)"
                }
            },

        -- algebra
            j_acad_liketerm = {
                name = "Like Terms",
                text = {
                    "{C:attention}Played Cards{} of the same {C:attention}suit",
                    "count as the same {C:attention}card",
                    "{C:inactive,s:0.8}(every card shares Enhancements and Editions)"
                }
            },

    -- SCIENCES
        
        -- Biology
            j_acad_adapt = {
                name = "Adaptation",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "Mult {C:attention}multiplies{} by",
                    "{X:mult,C:white}#2#x{} everytime {C:attention}blind",
                    "requirement isn't met"
                }
            },
            j_acad_mutual = {
                name = "Mutualism",
                text = {
                    "Earn {C:money}$#1#{} when the {C:attention}joker",
                    "to the right {C:attention}activates",
                    "Add {C:money}$#1#{} {C:attention}sell value{}",
                    "to associated {C:attention}Joker{}"
                }
            },
            j_acad_commen = {
                name = "Commensalism",
                text = {
                    "Earn {C:money}$#1#{} when the {C:attention}joker",
                    "to the right {C:attention}activates"
                }
            },
            j_acad_parasite = {
                name = "Parasitism",
                text = {
                    "Earn {C:money}$#1#{} when the {C:attention}joker",
                    "to the right {C:attention}scores",
                    "{C:inactive}(Cancels other joker's scoring effect)"
                }
            },

            j_acad_deathspiral   = {
                name = "Death Spiral",
                text = {
                    "Gains {C:mult}+#2#{} Mult",
                    "if played hand",
                    "contains 2 of the same rank",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                }
            },

        -- Astronomy 
            j_acad_astrophys = {
                name = "Astrophysician",
                text = {
                    "When {C:attention}blind{} is selected",
                    "create a {C:planet}Space{} {C:attention}Joker",
                    "{C:inactive}(Must have room)"
                }
            },
            j_acad_bang = {
                name = "The Big Bang",
                text = {
                    "Causes {C:attention}The Big Bang{} On sold",
                    "{C:inactive}(Restarts run to round 1)",
                    "{C:inactive}(All gained items persist)"
                }
            },
            j_acad_redshift = {
                name = "Redshift",
                text = {
                    "{C:attention}Final played card{} gives",
                    "{C:mult}Mult {C:attention}equal{} to its given {C:chips}Chips",
                    "No {C:chips}Chips{} added to {C:attention}score",
                }
            },
            j_acad_equinox = {
                name = "Equinox",
                text = {
                    "{C:attention}Balances{} {C:chips}Chips and {C:mult}Mult",
                    "{C:attention}before{} hand starts {C:attention}scoring",
                }
            },

    -- HUMANITIES

        -- Philosophy
            j_acad_twinpara = {
                name = "Twin Paradox",
                text = {
                    "{C:attention}Enhanced{} cards not {C:attention}held in hand{} at",
                    "{C:attention}end of round{}, have values",
                    "multiplied by {C:white,X:mult}X#1#"
                }
            },
        },
        Other = {
            acad_termial = {
                name = "Termial Function",
                text = {
                    "An {C:attention}additive{} version",
                    "of {C:attention}factorial{} adding",
                    "numbers instead of multiplying"
                }
            },
            acad_logarithm = {
                name = "Logarithm Function",
                text = {
                    "the {C:attention}opposite (inverse) ",
                    "of an {C:attention}exponent",
                    "2^3 = 8 | log2(8) = 3"
                }
            },
        },
        Planet = {},
        Spectral = {},
        Stake = {},
        Tag = {},
        Tarot = {},
        Voucher = {},
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {
            k_acad_cgrade =  "Current Grade: ",
            k_acad_lgrade =  "Last Grade: ",
            k_acad_agrade =  "Grade Achieved ",

            k_cancelled = "Cancelled!",
        -- Math
        -- i js tried to keep colors closest to the trello ones
        -- later I'll probably make a custom set `G.C.TOPIC`
            k_acad_math =    "Misc Math",            -- G.C.UI.TEXT_DARK
            k_acad_geom =    "Geometry",             -- G.C.GREEN
            k_acad_trig =    "Trigonometry",         -- G.C.GOLD
            k_acad_arith =   "Arithmetic",           -- G.C.PURPLE
            k_acad_alge =    "Algebra",              -- G.C.BLUE
            k_acad_calc =    "Calculus",             -- G.C.SECONDARY_SET.Planet
            k_acad_stfi =    "Stats and Finance",    -- G.C.SECONDARY_SET.Spectral
            k_acad_comp =    "Computer Science",     -- G.C.SECONDARY_SET.Enhanced

        -- Sciences
            k_acad_phys =    "Physics",              -- G.C.GREEN
            k_acad_bio =     "Biology",              -- G.C.GOLD
            k_acad_astro =   "Astronomy",            -- G.C.SECONDARY_SET.Planet

        -- Humanities
            k_acad_phil =    "Philosophy",              -- G.C.UI.TEXT_DARK
        },
        high_scores = {},
        labels = {},
        poker_hand_descriptions = {},
        poker_hands = {},
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {},
        v_text = {},
    },
}


