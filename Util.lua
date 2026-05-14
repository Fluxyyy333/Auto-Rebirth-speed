-- Combined Loader: Zeke Lite + Auto Trade Sender

getgenv().Config = {
    -- ========================
    -- ZEKE LITE (farming)
    -- ========================
    BabyFarm = true,
    PetFarm = {
        Enabled = true,
        FarmEggs = false,
        BuyEggs = false,
        EggTypes = {},
        BuyEggType = "any",
        MaxPets = 1,
        FarmUntilFullGrown = true,
        PrioritizeFriendship = false,
        SelectiveFarm = true,
        SelectedPetTypes = {
            "sugarfest_2026_mochi_meow",
            "endangered_2026_sea_turtle",
            "endangered_2026_blue_whale",
            "pet_progression_2026_purrowl",
        },
    },
    AutoNeon = {
        Enabled = true,
        MakeMega = false,
        NeonAll = false,
        SelectedPets = {
            "sugarfest_2026_mochi_meow",
            "endangered_2026_sea_turtle",
            "endangered_2026_blue_whale",
            "pet_progression_2026_purrowl",
        },
        MaxPerType = {},
    },
    AutoPotion = {
        Enabled = true,
        SelectedPets = {
            "sugarfest_2026_mochi_meow",
            "endangered_2026_sea_turtle",
            "endangered_2026_blue_whale",
            "pet_progression_2026_purrowl",
        },
        PotionVersionFilter = {},
    },
    AutoBuy = {
        Enabled = true,
        SelectedItems = {"pet_recycler_2025_crystal_egg","endangered_2026_endangered_egg"},
        BuyAmounts = {},
    },
    AutoOpen = {
        Enabled = false,
        Items = {},
    },
    AutoRecycle = {
        Enabled = true,
        RarityFilter = {
            common = {"regular","neon","mega"},
            uncommon = {"regular","neon","mega"},
            rare = {"regular","neon","mega"},
            ultra_rare = {"regular","neon","mega"},
        },
        AgeFilter = {},
        ExcludedPets = {},
    },
    IdleProgression = {
        Enabled = true,
        SelectedPets = {"endangered_2026_endangered_egg"},
        ExcludedPets = {
            "sugarfest_2026_gumball_caterpillar",
            "admin_abuse_egg_2026_egg",
            "pet_recycler_2025_crystal_egg",
            "penguins_2025_dango_penguins",
            "food_pets_2026_dragonfruit_fox",
            "endangered_2026_silverback_gorilla",
            "lss_2026_glormy_crab",
            "sugarfest_2026_mochi_meow",
            "endangered_2026_sea_turtle",
            "endangered_2026_blue_whale",
            "pet_progression_2026_purrowl",
            "admin_abuse_2025_sushi_penguin",
            "admin_abuse_egg_2026_robot_chicken",
        },
        PriorityOrder = {"regular"},
        PenVersionFilter = {},
    },
    Settings = {
        ShowOverlay = true,
        ReduceGraphics = true,
        FPSCap = 2,
        LureId = "ice_dimension_2025_ice_soup_bait",
    },
    Webhook = {
        Enabled = false,
        URL = "",
        PetUnlock = {
            Enabled = false,
            URL = "",
            FilterRarities = {},
        },
    },
    TaskExclusion = {
        Enabled = false,
        ExcludedTasks = {},
    },

    -- ========================
    -- AUTO TRADE (sender)
    -- ========================
    AutoTrade = {
        Enabled = true,
        Receivers = {
            "123_dEu63",
            "3grh2_hr",
            "udkc_jfx",
            "ya55min_570166",
            "1_flamingofan1011",
            "lucius236523",
            "Ba_byEr1c04",
            "TaughtGras_sNice91",
            "17k_vixxbe17",
            "3gSgs_6",
        },
        TradeMode = "specific",
        Categories = {"pets"},
        Items = {
            "sugarfest_2026_dark_choccybunny",
            "sugarfest_2026_mochi_meow",
            "sugarfest_2026_easter_bunny",
            "penguins_2025_dango_penguins",
            "food_pets_2026_dragonfruit_fox",
            "endangered_2026_silverback_gorilla",
            "endangered_2026_sea_turtle",
            "endangered_2026_blue_whale",
            "pet_progression_2026_purrowl",
            "lss_2026_glormy_crab",
            "admin_abuse_2025_sushi_penguin",
            "admin_abuse_egg_2026_robot_chicken",
            "admin_abuse_egg_2026_egg",
        },
        ItemCounts = {},
        GlobalPetFilter = {
            Versions = {},
            Ages = {},
        },
        PetFilters = {
            sugarfest_2026_dark_choccybunny = {
                regular = {6},
                neon = {},
                mega = {},
            },
            sugarfest_2026_mochi_meow = {
                neon = {6},
                mega = {},
            },
            sugarfest_2026_easter_bunny = {
                regular = {6},
                neon = {},
                mega = {},
            },
            penguins_2025_dango_penguins = {
                regular = {},
                neon = {},
                mega = {},
            },
            food_pets_2026_dragonfruit_fox = {
                regular = {},
                neon = {},
                mega = {},
            },
            endangered_2026_silverback_gorilla = {
                regular = {},
                neon = {},
                mega = {},
            },
            endangered_2026_sea_turtle = {
                neon = {6},
                mega = {},
            },
            endangered_2026_blue_whale = {
                neon = {6},
                mega = {},
            },
            pet_progression_2026_purrowl = {
                neon = {6},
                mega = {},
            },
            lss_2026_glormy_crab = {
                regular = {},
                neon = {},
                mega = {},
            },
            admin_abuse_2025_sushi_penguin = {
                regular = {},
                neon = {},
                mega = {},
            },
            admin_abuse_egg_2026_robot_chicken = {
                regular = {},
                neon = {},
                mega = {},
            },
        },
    },
}
