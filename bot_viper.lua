-------------------------------------------------------------------------------
--- AUTHOR: Nostrademous
--- GITHUB REPO: https://github.com/Nostrademous/Dota2-FullOverwrite
-------------------------------------------------------------------------------

require( GetScriptDirectory().."/constants" )
require ( GetScriptDirectory().."/ability_usage_viper" )

local utils = require( GetScriptDirectory().."/utility" )
local dt = require( GetScriptDirectory().."/decision_tree" )
local gHeroVar = require( GetScriptDirectory().."/global_hero_data" )

local SKILL_Q = "viper_poison_attack";
local SKILL_W = "viper_nethertoxin";
local SKILL_E = "viper_corrosive_skin";
local SKILL_R = "viper_viper_strike";

local ABILITY1 = "special_bonus_attack_damage_15"
local ABILITY2 = "special_bonus_hp_150"
local ABILITY3 = "special_bonus_strength_7"
local ABILITY4 = "special_bonus_agility_14"
local ABILITY5 = "special_bonus_armor_7"
local ABILITY6 = "special_bonus_attack_range_75"
local ABILITY7 = "special_bonus_unique_viper_1"
local ABILITY8 = "special_bonus_unique_viper_2"

local ViperAbilityPriority = {
    SKILL_Q,    SKILL_E,    SKILL_W,    SKILL_E,    SKILL_W,
    SKILL_R,    SKILL_W,    SKILL_W,    SKILL_Q,    ABILITY2,
    SKILL_Q,    SKILL_R,    SKILL_Q,    SKILL_E,    ABILITY4,
    SKILL_E,    SKILL_R,    ABILITY6,   ABILITY8
};

local viperModeStack = { [1] = constants.MODE_NONE }

ViperBot = dt:new()

function ViperBot:new(o)
    o = o or dt:new(o)
    setmetatable(o, self)
    self.__index = self
    return o
end

viperBot = ViperBot:new{modeStack = viperModeStack, abilityPriority = ViperAbilityPriority}
--viperBot:printInfo();

viperBot.Init = false

function viperBot:DoHeroSpecificInit(bot)
    self:setHeroVar("HasOrbAbility", SKILL_Q)
end

function viperBot:ConsiderAbilityUse(nearbyEnemyHeroes, nearbyAlliedHeroes, nearbyEnemyCreep, nearbyAlliedCreep, nearbyEnemyTowers, nearbyAlliedTowers)
    return ability_usage_viper.AbilityUsageThink(nearbyEnemyHeroes, nearbyAlliedHeroes, nearbyEnemyCreep, nearbyAlliedCreep, nearbyEnemyTowers, nearbyAlliedTowers)
end

function Think()
    local bot = GetBot()

    viperBot:Think(bot)
    
    -- if we are initialized, do the rest
    if viperBot.Init then
        gHeroVar.ExecuteHeroActionQueue(bot)
    end
end
