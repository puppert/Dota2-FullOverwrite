-------------------------------------------------------------------------------
--- AUTHOR: Nostrademous
--- CONTRIBUTOR: Many functions copied from work by Platinum_dota2
--- GITHUB REPO: https://github.com/Nostrademous/Dota2-FullOverwrite
-------------------------------------------------------------------------------

require( GetScriptDirectory().."/constants" )
local gHeroVar = require( GetScriptDirectory().."/global_hero_data" )

-------------------------------------------------------------------------------
-- Inits
-------------------------------------------------------------------------------

U = {}

-------------------------------------------------------------------------------
-- Declarations
-------------------------------------------------------------------------------

U.creeps = nil
U.Lanes={[1]=LANE_BOT,[2]=LANE_MID,[3]=LANE_TOP};

U.Locations = {
["RadiantShop"]= Vector(-4739,1263),
["DireShop"]= Vector(4559,-1554),
["BotShop"]= Vector(7253,-4128),
["TopShop"]= Vector(-7236,4444),

["RadiantBase"]= Vector(-7200,-6666),
["RBT1"]= Vector(4896,-6140),
["RBT2"]= Vector(-128,-6244),
["RBT3"]= Vector(-3966,-6110),
["RMT1"]= Vector(-1663,-1510),
["RMT2"]= Vector(-3559,-2783),
["RMT3"]= Vector(-4647,-4135),
["RTT1"]= Vector(-6202,1831),
["RTT2"]= Vector(-6157,-860),
["RTT3"]= Vector(-6591,-3397),
["RadiantTopShrine"]= Vector(-4229,1299),
["RadiantBotShrine"]= Vector(622,-2555),

["DireBase"]= Vector(7137,6548),
["DBT1"]= Vector(6215,-1639),
["DBT2"]= Vector(6242,400),
["DBT3"]= Vector(-6307,3043),
["DMT1"]= Vector(1002,330),
["DMT2"]= Vector(2477,2114),
["DMT3"]= Vector(4197,3756),
["DTT1"]= Vector(-4714,6016),
["DTT2"]= Vector(0,6020),
["DTT3"]= Vector(3512,5778),
["DireTopShrine"]= Vector(-139,2533),
["DireBotShrine"]= Vector(4173,-1613),
};

U["tableNeutralCamps"] = {
    [constants.TEAM_RADIANT] = {
        [1] = {
            [constants.DIFFICULTY] = constants.CAMP_EASY,
            [constants.VECTOR] = constants.RAD_SAFE_EASY,
            [constants.STACK_TIME] = constants.RAD_SAFE_EASY_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_SAFE_EASY_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_SAFE_EASY_STACK
        },
        [2] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.RAD_SAFE_MEDIUM,
            [constants.STACK_TIME] = constants.RAD_SAFE_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_SAFE_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_SAFE_MEDIUM_STACK
        },
        [3] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.RAD_MID_MEDIUM,
            [constants.STACK_TIME] = constants.RAD_MID_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_MID_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_MID_MEDIUM_STACK
        },
        [4] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.RAD_OFF_MEDIUM,
            [constants.STACK_TIME] = constants.RAD_OFF_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_OFF_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_OFF_MEDIUM_STACK
        },
        [5] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.RAD_OFF_HARD,
            [constants.STACK_TIME] = constants.RAD_OFF_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_OFF_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_OFF_HARD_STACK
        },
        [6] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.RAD_MID_HARD,
            [constants.STACK_TIME] = constants.RAD_MID_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_MID_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_MID_HARD_STACK
        },
        [7] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.RAD_SAFE_HARD,
            [constants.STACK_TIME] = constants.RAD_SAFE_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_SAFE_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_SAFE_HARD_STACK
        },
        [8] = {
            [constants.DIFFICULTY] = constants.CAMP_ANCIENT,
            [constants.VECTOR] = constants.RAD_MID_ANCIENT,
            [constants.STACK_TIME] = constants.RAD_MID_ANCIENT_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_MID_ANCIENT_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_MID_ANCIENT_STACK
        },
        [9] = {
            [constants.DIFFICULTY] = constants.CAMP_ANCIENT,
            [constants.VECTOR] = constants.RAD_OFF_ANCIENT,
            [constants.STACK_TIME] = constants.RAD_OFF_ANCIENT_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.RAD_OFF_ANCIENT_PRESTACK,
            [constants.STACK_VECTOR] = constants.RAD_OFF_ANCIENT_STACK
        }
    },
    [constants.TEAM_DIRE] = {
        [1] = {
            [constants.DIFFICULTY] = constants.CAMP_EASY,
            [constants.VECTOR] = constants.DIRE_SAFE_EASY,
            [constants.STACK_TIME] = constants.DIRE_SAFE_EASY_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_SAFE_EASY_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_SAFE_EASY_STACK
        },
        [2] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.DIRE_SAFE_MEDIUM,
            [constants.STACK_TIME] = constants.DIRE_SAFE_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_SAFE_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_SAFE_MEDIUM_STACK
        },
        [3] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.DIRE_MID_MEDIUM,
            [constants.STACK_TIME] = constants.DIRE_MID_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_MID_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_MID_MEDIUM_STACK
        },
        [4] = {
            [constants.DIFFICULTY] = constants.CAMP_MEDIUM,
            [constants.VECTOR] = constants.DIRE_OFF_MEDIUM,
            [constants.STACK_TIME] = constants.DIRE_OFF_MEDIUM_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_OFF_MEDIUM_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_OFF_MEDIUM_STACK
        },
        [5] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.DIRE_OFF_HARD,
            [constants.STACK_TIME] = constants.DIRE_OFF_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_OFF_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_OFF_HARD_STACK
        },
        [6] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.DIRE_MID_HARD,
            [constants.STACK_TIME] = constants.DIRE_MID_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_MID_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_MID_HARD_STACK
        },
        [7] = {
            [constants.DIFFICULTY] = constants.CAMP_HARD,
            [constants.VECTOR] = constants.DIRE_SAFE_HARD,
            [constants.STACK_TIME] = constants.DIRE_SAFE_HARD_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_SAFE_HARD_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_SAFE_HARD_STACK
        },
        [8] = {
            [constants.DIFFICULTY] = constants.CAMP_ANCIENT,
            [constants.VECTOR] = constants.DIRE_MID_ANCIENT,
            [constants.STACK_TIME] = constants.DIRE_MID_ANCIENT_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_MID_ANCIENT_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_MID_ANCIENT_STACK
        },
        [9] = {
            [constants.DIFFICULTY] = constants.CAMP_ANCIENT,
            [constants.VECTOR] = constants.DIRE_OFF_ANCIENT,
            [constants.STACK_TIME] = constants.DIRE_OFF_ANCIENT_STACKTIME,
            [constants.PRE_STACK_VECTOR] = constants.DIRE_OFF_ANCIENT_PRESTACK,
            [constants.STACK_VECTOR] = constants.DIRE_OFF_ANCIENT_STACK
        }
    }
}

U.SIDE_SHOP_TOP = Vector(-7220,4430);
U.SIDE_SHOP_BOT = Vector(7249,-4113);
U.SECRET_SHOP_RADIANT = Vector(-4472,1328);
U.SECRET_SHOP_DIRE = Vector(4586,-1588);
U.ROSHAN = Vector(-2450, 1880);

U.MapSafeSpots = {
    Vector(-7180, 4811),
    Vector(-6237, 4985),
    Vector(-6998, 3659),
    Vector(-5255, 4484),
    Vector(-6159, 3385),
    Vector(-4433, 4719),
    Vector(-3377, 5090),
    Vector(-2825, 4122),
    Vector(-3255, 5888),
    Vector(-2217, 6228),
    Vector(-1943, 4920),
    Vector(-795, 4994),
    Vector(-22, 4096),
    Vector(-1547, 3720),
    Vector(-934, 3393),
    Vector(-1973, 2805),
    Vector(-3560, 2460),
    Vector(1521, 4209),
    Vector(2843, 3738),
    Vector(2104, 3646),
    Vector(1817, 2787),
    Vector(1039, 2342),
    Vector(3990, 2831),
    Vector(-196, 2329),
    Vector(4173, 1950),
    Vector(3599, 1042),
    Vector(3160, -148),
    Vector(5146, 1849),
    Vector(1965, 571),
    Vector(1982, -113),
    Vector(2399, -1029),
    Vector(1669, -816),
    Vector(-335, 1282),
    Vector(-300, 209),
    Vector(-1743, 1195),
    Vector(-2012, 462),
    Vector(-2504, 9),
    Vector(-3338, -1213),
    Vector(-1221, -471),
    Vector(-517, -1230),
    Vector(-535, -2006),
    Vector(-1274, -2486),
    Vector(700, -2608),
    Vector(2021, -2425),
    Vector(2838, -2085),
    Vector(4386, -1535),
    Vector(4803, -131),
    Vector(-4525, 1317),
    Vector(-5003, 314),
    Vector(-5994, 628),
    Vector(-3447, -1117),
    Vector(-4872, -1056),
    Vector(-4412, -1884),
    Vector(-2873, -2041),
    Vector(-2417, -2465),
    Vector(-2404, -2791),
    Vector(-1908, -3027),
    Vector(-1704, -3795),
    Vector(-400, -4353),
    Vector(1095, -4327),
    Vector(-2817, -3969),
    Vector(1469, -4745),
    Vector(3269, -5295),
    Vector(3156, -6132),
    Vector(2025, -6211),
    Vector(3703, -3768),
    Vector(4486, -5033),
    Vector(5972, -4964),
    Vector(7354, -4144),
    Vector(7467, -3149)
}

U.RadiantSafeSpots = {unpack(U.MapSafeSpots)}
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RadiantBase
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RBT1
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RBT2
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RBT3
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RMT1
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RMT2
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RMT3
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RTT1
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RTT2
U.RadiantSafeSpots[#U.RadiantSafeSpots+1] = U.Locations.RTT3

U.DireSafeSpots = {unpack(U.MapSafeSpots)}
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DireBase
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DBT1
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DBT2
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DBT3
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DMT1
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DMT2
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DMT3
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DTT1
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DTT2
U.DireSafeSpots[#U.DireSafeSpots+1] = U.Locations.DTT3

-------------------------------------------------------------------------------
-- Properties
-------------------------------------------------------------------------------

function setHeroVar(var, value)
    local bot = GetBot()
    gHeroVar.SetVar(bot:GetPlayerID(), var, value)
end

function getHeroVar(var)
    local bot = GetBot()
    return gHeroVar.GetVar(bot:GetPlayerID(), var)
end

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

function U.GetOppositeTeamTo(team)
  if team == constants.TEAM_RADIANT then
    return constants.TEAM_DIRE
  else
    return constants.TEAM_RADIANT
  end
end

-------------------------------------------------------------------------------
-- Table Functions
-------------------------------------------------------------------------------

function U.InTable (tab, val)
    if not tab then return false end
    for index, value in ipairs (tab) do
        if value == val then
            return true
        end
    end

    return false
end

function U.PosInTable(tab, val)
    for index,value in ipairs(tab) do
        if value == val then
            return index
        end
    end

    return -1
end

function U.Spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function U.PairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0                 -- iterator variable
    local iter = function ()    -- iterator function
       i = i + 1
       if a[i] == nil then return nil
       else return a[i], t[a[i]]
       end
    end
    return iter
end

function U.SortFunc(a , b)
    if a < b then
        return true
    end
end

function U.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[U.deepcopy(orig_key)] = U.deepcopy(orig_value)
        end
        setmetatable(copy, U.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function U.clone(org)
    return {unpack(org)}
end

-------------------------------------------------------------------------------
-- Math Functions
-------------------------------------------------------------------------------

function U.CheckFlag(bitfield, flag)
    return ((bitfield/flag) % 2) >= 1
end

function U.GetDistance(s, t)
    --print("S1: "..s[1]..", S2: "..s[2].." :: T1: "..t[1]..", T2: "..t[2]);
    return math.sqrt((s[1]-t[1])*(s[1]-t[1]) + (s[2]-t[2])*(s[2]-t[2]));
end

function U.VectorTowards(start, towards, distance)
    local facing = towards - start
    local direction = facing / U.GetDistance(facing, Vector(0,0)) --normalized
    return start + (direction * distance)
end

function U.VectorAway(start, towards, distance)
    local facing = start - towards
    local direction = facing / U.GetDistance(facing, Vector(0,0)) --normalized
    return start + (direction * distance)
end

function U.Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function U.GetHeightDiff(hUnit1, hUnit2)
    if type(hUnit2) == "number" then -- case for trees
        return (hUnit1:GetGroundHeight() - hUnit2)
    end
    return (hUnit1:GetGroundHeight() - hUnit2:GetGroundHeight())
end

function U.EnemyDistanceFromTheirAncient( hEnemy )
    local locAncient = GetAncient(U.GetOtherTeam()):GetLocation()
    if U.ValidTarget( hEnemy ) then
        return U.GetDistance( locAncient, hEnemy.Obj:GetLocation() )
    else
        local timeSinceSeen = GetHeroLastSeenInfo(hEnemy.Id).time
        if  timeSinceSeen > 3 then
            return 0
        elseif timeSinceSeen <= 0.5 then
            return U.GetDistance( locAncient, hEnemy.LocExtra1 )
        elseif timeSinceSeen <= 3.0 then
            return U.GetDistance( locAncient, hEnemy.LocExtra2 )
        end
    end
    return 0
end

function U.TimeForEnemyToGetIntoTheirBase( hEnemy )
    local distFromBase = U.EnemyDistanceFromTheirAncient( hEnemy )
    if U.ValidTarget( hEnemy ) then
        return distFromBase/hEnemy.Obj:GetCurrentMovementSpeed()
    end
    return distFromBase/hEnemy.MoveSpeed
end

-- CONTRIBUTOR: Function below was coded by Platinum_dota2
function U.IsFacingLocation(hero, loc, delta)
    local facing = hero:GetFacing()
    local moveVect = loc - hero:GetLocation()

    moveVect = moveVect / (U.GetDistance(Vector(0,0), moveVect))

    local moveAngle = math.atan2(moveVect.y, moveVect.x)/math.pi * 180

    if moveAngle < 0 then
        moveAngle = 360 + moveAngle
    end
    facing = (facing + 360) % 360

    if (math.abs(moveAngle - facing) < delta or
        math.abs(moveAngle + 360 - facing) < delta or
        math.abs(moveAngle - 360 - facing) < delta) then
        return true
    end
    return false
end

-- CONTRIBUTOR: Function below was coded by Platinum_dota2
function U.AreTreesBetweenMeAndLoc(loc, lineOfSightThickness)
    local npcBot = GetBot()

    local trees = npcBot:GetNearbyTrees(GetUnitToLocationDistance(npcBot, loc))

    --check if there are trees between us and location with line-of-sight thickness
    for _, tree in ipairs(trees) do
        local x = GetTreeLocation(tree)
        local y = npcBot:GetLocation()
        local z = loc

        if x ~= y then
            local a = 1
            local b = 1
            local c = 0

            if x.x - y.x == 0 then
                b = 0
                c = -x.x
            else
                a =- (x.y - y.y)/(x.x - y.x)
                c =- (x.y + x.x*a)
            end

            local d = math.abs((a*z.x + b*z.y + c)/math.sqrt(a*a + b*b))
            if d <= lineOfSightThickness and
                GetUnitToLocationDistance(npcBot, loc) > (U.GetDistance(x,loc) + 50) then
                return true
            end
        end
    end
    return false
end

-- CONTRIBUTOR: Function below was based off above function by Platinum_dota2
function U.AreEnemyCreepsBetweenMeAndLoc(loc, lineOfSightThickness)
    local npcBot = GetBot()

    local eCreeps = npcBot:GetNearbyCreeps(GetUnitToLocationDistance(npcBot, loc), true)

    --check if there are enemy creeps between us and location with line-of-sight thickness
    for _, eCreep in ipairs(eCreeps) do
        local x = eCreep:GetLocation()
        local y = npcBot:GetLocation()
        local z = loc

        if x ~= y then
            local a = 1
            local b = 1
            local c = 0

            if x.x - y.x == 0 then
                b = 0
                c = -x.x
            else
                a =- (x.y - y.y)/(x.x - y.x)
                c =- (x.y + x.x*a)
            end

            local d = math.abs((a*z.x + b*z.y + c)/math.sqrt(a*a + b*b))
            if d <= lineOfSightThickness and
                GetUnitToLocationDistance(npcBot, loc) > (U.GetDistance(x,loc) + 50) then
                return true
            end
        end
    end
    return false
end

-- CONTRIBUTOR: Function below was based off above function by Platinum_dota2
function U.AreFriendlyCreepsBetweenMeAndLoc(loc, lineOfSightThickness)
    local npcBot = GetBot()

    local fCreeps = npcBot:GetNearbyCreeps(GetUnitToLocationDistance(npcBot, loc), false)

    --check if there are enemy creeps between us and location with line-of-sight thickness
    for _, fCreep in ipairs(fCreeps) do
        local x = fCreep:GetLocation()
        local y = npcBot:GetLocation()
        local z = loc

        if x ~= y then
            local a = 1
            local b = 1
            local c = 0

            if x.x - y.x == 0 then
                b = 0
                c = -x.x
            else
                a =- (x.y - y.y)/(x.x - y.x)
                c =- (x.y + x.x*a)
            end

            local d = math.abs((a*z.x + b*z.y + c)/math.sqrt(a*a + b*b))
            if d <= lineOfSightThickness and
                GetUnitToLocationDistance(npcBot, loc) > (U.GetDistance(x,loc) + 50) then
                return true
            end
        end
    end
    return false
end

-- CONTRIBUTOR: Function below was based off above function by Platinum_dota2
function U.AreCreepsBetweenMeAndLoc(loc, lineOfSightThickness)
    if not U.AreEnemyCreepsBetweenMeAndLoc(loc, lineOfSightThickness) then
        return U.AreFriendlyCreepsBetweenMeAndLoc(loc, lineOfSightThickness)
    end
    return true
end

-------------------------------------------------------------------------------
-- General Hero Functions
-------------------------------------------------------------------------------

function U.GetHeroName(bot)
    local sName = bot:GetUnitName()
    return string.sub(sName, 15, string.len(sName));
end

function U.IsCore()
    if getHeroVar("Role") == constants.ROLE_HARDCARRY
        or getHeroVar("Role") == constants.ROLE_MID
        or getHeroVar("Role") == constants.ROLE_OFFLANE
        or getHeroVar("Role") == constants.ROLE_JUNGLER then
            return true;
    end

    return false;
end

function U.IsMelee(hero)
    --NOTE: Monkey King is considered Melee with a range of 300, typical melee heroes are range 150
    if hero:GetAttackRange() < 320.0 then return true end
    return false
end

function U.PartyChat(msg)
    local bot = GetBot()
    bot:ActionImmediate_Chat(msg, false)
end

function U.AllChat(msg)
    local bot = GetBot()
    bot:ActionImmediate_Chat(msg, true)
end

function U.ValidTarget(target)
    if target.Obj ~= nil and not target.Obj:IsNull() then
        return true
    end
    return false
end

function U.NotNilOrDead(unit)
    if unit==nil then
        return false;
    end
    if unit:IsAlive() then
        return true;
    end
    return false;
end

function U.TimePassed(prevTime, amount)
    if ( (GameTime() - prevTime) > amount ) then
        return true, GameTime()
    else
        return false, GameTime()
    end
end

function U.LevelUp(bot, AbilityPriority)
    if ( GetGameState() ~= GAME_STATE_GAME_IN_PROGRESS and GetGameState() ~= GAME_STATE_PRE_GAME ) then return end

    local ability = bot:GetAbilityByName(AbilityPriority[1])

    if ( ability == nil ) then
        U.myPrint(" FAILED AT Leveling " .. AbilityPriority[1] )
        table.remove( AbilityPriority, 1 )
        return
    end

    if ( ability:CanAbilityBeUpgraded() and ability:GetLevel() < ability:GetMaxLevel() ) then
        bot:ActionImmediate_LevelAbility(AbilityPriority[1])
        U.myPrint( " Leveling " .. ability:GetName() )
        table.remove( AbilityPriority, 1 )
    end
end

function U.GetOtherTeam()
    if GetTeam()==TEAM_RADIANT then
        return TEAM_DIRE
    else
        return TEAM_RADIANT
    end
end

function U.TreadCycle(bot, stat)
    --[[
    local powerTreads = U.HaveItem(bot, "item_power_treads")
    if powerTreads then
        local activeStat = powerTreads:GetPowerTreadsStat()
        if activeState == stat then return end
        for i = 0, 2, 1 do
            activeStat = powerTreads:GetPowerTreadsStat()
            gHeroVar.HeroUseAbility(bot, powerTreads)
            if activeStat == stat then return end
        end
    end
    --]]
end

-------------------------------------------------------------------------------
-- Hero Movement Functions
-------------------------------------------------------------------------------

function U.PositionAlongLane(bot, lane)
    local botPos = bot:GetLocation()
    local fAmount = GetAmountAlongLane(lane, botPos)
    local bInLane = false
    if fAmount.distance <= 1600 then
        bInLane = true
    end
    setHeroVar("IsInLane", bInLane)

    return fAmount.amount
end

-- CONTRIBUTOR: Function below was coded by Platinum_dota2
function U.MoveSafelyToLocation(npcBot, dest)
    if getHeroVar("NextHop")==nil or #getHeroVar("NextHop")==0 or getHeroVar("PathfindingWasInitiated")==nil or (not getHeroVar("PathfindingWasInitiated")) then
        U.InitPathFinding(npcBot)
        U.myPrint("Path finding has been initiated")
    end

    local safeSpots = nil
    local safeDist = 2000
    if dest==nil then
        U.myPrint("PathFinding: No destination was specified")
        return
    end

    if GetTeam()==TEAM_RADIANT then
        safeSpots = U.RadiantSafeSpots
    else
        safeSpots = U.DireSafeSpots
    end

    if getHeroVar("FinalHop")==nil then
        setHeroVar("FinalHop", false)
    end


    local s=nil;
    local si=-1;
    local mindisS=100000;

    local t=nil;
    local ti=-1;
    local mindisT=100000;

    local CurLoc = npcBot:GetLocation()

    for i,spot in pairs(safeSpots) do
        if U.GetDistance(spot,CurLoc)<mindisS then
            s=spot;
            si=i;
            mindisS=U.GetDistance(spot,CurLoc);
        end

        if U.GetDistance(spot,dest)<mindisT then
            t=spot;
            ti=i;
            mindisT=U.GetDistance(spot,dest);
        end
    end

    if s==nil or t==nil then
        U.AllChat('Something is wrong with path finding.')
        return
    end

    if GetUnitToLocationDistance(npcBot,dest)<safeDist or getHeroVar("FinalHop") or mindisS+mindisT>GetUnitToLocationDistance(npcBot,dest) then
        gHeroVar.HeroMoveToLocation(npcBot, dest)
        setHeroVar("FinalHop", true)
        return;
    end

    if si==ti then
        setHeroVar("FinalHop", true)
        gHeroVar.HeroMoveToLocation(npcBot, dest)
        return;
    end

    if GetUnitToLocationDistance(npcBot,s)<500 and getHeroVar("LastHop")==nil then
        setHeroVar("LastHop", si)
    end

    if mindisS>safeDist or getHeroVar("LastHop")==nil then
        gHeroVar.HeroMoveToLocation(npcBot, s)
        return
    end

    if GetUnitToLocationDistance(npcBot,safeSpots[getHeroVar("NextHop")[getHeroVar("LastHop")][ti]])<500 then
        setHeroVar("LastHop", getHeroVar("NextHop")[getHeroVar("LastHop")][ti])
    end

    local newT = getHeroVar("NextHop")[getHeroVar("LastHop")][ti]

    gHeroVar.HeroMoveToLocation(npcBot, safeSpots[newT])
end

function U.InitPathFinding(npcBot)

    -- keeps the path for my pathfinding
    setHeroVar("NextHop", {})
    setHeroVar("PathfindingWasInitiated", false)
    -- creating the graph

    local SafeDist=2000;
    local safeSpots={};
    if GetTeam()==TEAM_RADIANT then
        safeSpots=U.RadiantSafeSpots;
    else
        safeSpots=U.DireSafeSpots;
    end

    --initialization
    local inf=100000
    local dist={}
    local NextHop={}

    U.myPrint("Inits are done")
    for u,uv in pairs(safeSpots) do
        local q=true;
        dist[u]={};
        NextHop[u]={};
        for v,vv in pairs(safeSpots) do
            if U.GetDistance(uv,vv)>SafeDist then
                dist[u][v]=inf;
            else
                q=false;
                dist[u][v]=U.GetDistance(uv,vv);
            end
            NextHop[u][v]=v;
        end
        if q then
            U.myPrint("There is an isolated vertex in safespots")
        end
    end

    --floyd algorithm (path is saved in NextHop)
    for k,_ in pairs(safeSpots) do
        for u,_ in pairs(safeSpots) do
            for v,_ in pairs(safeSpots) do
                if dist[u][v]>dist[u][k]+dist[k][v] then
                    dist[u][v]=dist[u][k]+dist[k][v];
                    NextHop[u][v]=NextHop[u][k];
                end
            end
        end
    end

    setHeroVar("NextHop", NextHop)
    setHeroVar("PathfindingWasInitiated", true)
end

function U.InitPath(npcBot)
    setHeroVar("FinalHop", false)
    setHeroVar("LastHop", nil)
end

function U.IsInLane()
    local bot = GetBot()

    setHeroVar("RetreatLane", getHeroVar("CurLane"))
    setHeroVar("RetreatPos", getHeroVar("LanePos"))

    for i = 1, #U.Lanes, 1 do
        local this = U.PositionAlongLane(bot, U.Lanes[i])

        if getHeroVar("IsInLane") then
            setHeroVar("RetreatLane", U.Lanes[i])
            setHeroVar("RetreatPos", thisl)
            break
        end
    end

    return getHeroVar("IsInLane"), getHeroVar("RetreatLane")
end

function U.EnemiesNearLocation(bot, loc, dist)
    if loc == nil then
        return 0
    end

    local num = 0
    --FIXME: this list below only returns visible heroes, need to do this for all alive heroes
    local listEnemies = GetUnitList(UNIT_LIST_ENEMY_HEROES)
    for _, enemy in pairs(listEnemies) do
        local eID = enemy:GetPlayerID()
        if U.ValidTarget(enemy) and IsHeroAlive(eID) and U.GetDistance(enemy:GetLocation(), loc) <= dist then
            num = num + 1
        end
    end

    return num
end

function U.GetWardingSpot(lane)
    -- GOOD RESOURCE: http://devilesk.com/dota2/apps/interactivemap3/?x=426&y=96&zoom=0

    local laneTower1 = U.GetLaneTower(U.GetOtherTeam(), lane, 1)
    local laneTower2 = U.GetLaneTower(U.GetOtherTeam(), lane, 2)

    if U.NotNilOrDead(laneTower1) then
        --U.myPrint(" - WARDING - lane tower 1 still up, placing wards accordingly")
        if GetTeam() == TEAM_RADIANT then
            if lane == LANE_BOT then
                return {Vector(3552, -1522), Vector(5684, -3228)}
            elseif lane == LANE_MID then
                return {Vector(-874, 1191)}
            elseif lane == LANE_TOP then
                return {Vector(-3069, 3873)}
            end
        else
            if lane == LANE_TOP then
                return {Vector(-5105, 2083)}
            elseif lane == LANE_MID then
                return {Vector(-130, -1047)}
            elseif lane == LANE_BOT then
                return {Vector(4199, -4763)}
            end
        end
    elseif U.NotNilOrDead(laneTower2) then
        if GetTeam() == TEAM_RADIANT then
            if lane == LANE_BOT then
                return {Vector(5072, 761), Vector(3096, -211)}
            elseif lane == LANE_MID then
                return {Vector(218, 2393)}
            elseif lane == LANE_TOP then
                return {Vector(1021, 4641)}
            end
        else
            if lane == LANE_TOP then
                return {Vector(-4380, -1283)}
            elseif lane == LANE_MID then
                return {Vector(-4380, -1283)}
            elseif lane == LANE_BOT then
                return {Vector(-1035, -4588)}
            end
        end
    else
        U.myPrint("WARDING: Not implemented past a tower dropping...")
        return nil
    end
    return nil
end

-------------------------------------------------------------------------------
-- Neutral Functions
-------------------------------------------------------------------------------

-- TODO: should be broken, from looking at it (U["tableNeutralCamps"][CAMP_EASY] etc. doenst make sense)
function U.DistanceToNeutrals(hUnit, largestCampType)
    local camps = {}
    local sCamps = {}
    for i,v in ipairs(U["tableNeutralCamps"][CAMP_EASY]) do
        camps[GetUnitToLocationDistance( hUnit, v )] = v
    end
    if largestCampType == CAMP_EASY then
        for k,v in U.Spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
            sCamps[k] = v
        end
        return camps
    end
    for i,v in ipairs(U["tableNeutralCamps"][CAMP_MEDIUM]) do
        camps[GetUnitToLocationDistance( hUnit, v )] = v
    end
    if largestCampType == CAMP_MEDIUM then
        for k,v in U.Spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
            sCamps[k] = v
        end
    return camps
    end
    for i,v in ipairs(U["tableNeutralCamps"][CAMP_HARD]) do
        camps[GetUnitToLocationDistance( hUnit, v )] = v
    end
    if largestCampType == CAMP_HARD then
        for k,v in U.Spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
            sCamps[k] = v
        end
        return camps
    end
    for i,v in ipairs(U["tableNeutralCamps"][CAMP_ANCIENT]) do
        camps[GetUnitToLocationDistance( hUnit, v )] = v
    end

    for k,v in U.Spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
        sCamps[k] = v
    end
    return camps
end

function U.NextNeutralSpawn()
    if DotaTime() < 30 then
        return 30
    else
        t = math.ceil((DotaTime() - 60) / 120) * 120 + 60
        U.myPrint("Next spawn time is ", t)
        return t
    end
end

function U.NearestNeutralCamp( hUnit, tCamps )
    local closestDistance = 1000000
    local closestCamp = nil
    local secondClosestCamp = nil
    for k,v in ipairs(tCamps) do
        if v ~= nil and GetUnitToLocationDistance( hUnit, v[constants.VECTOR] ) < closestDistance then
            closestDistance = GetUnitToLocationDistance( hUnit, v[constants.VECTOR] )
            if closestCamp ~= nil then secondClosestCamp = closestCamp end
            closestCamp = v
            --print(closestCamp..":"..closestDistance)
        end
    end
    return closestCamp, secondClosestCamp
end

-------------------------------------------------------------------------------
-- Towers & Buildings Functions
-------------------------------------------------------------------------------

function U.GetTowerLocation(side, lane, n) --0 radiant 1 dire
    if (side==0) then
        if (lane==LANE_TOP) then
            if (n==1) then
                return U.Locations["RTT1"];
            elseif (n==2) then
                return U.Locations["RTT2"];
            elseif (n==3) then
                return U.Locations["RTT3"];
            end
        elseif (lane==LANE_MID) then
            if (n==1) then
                return U.Locations["RMT1"];
            elseif (n==2) then
                return U.Locations["RMT2"];
            elseif (n==3) then
                return U.Locations["RMT3"];
            end
        elseif (lane==LANE_BOT) then
            if (n==1) then
                return U.Locations["RBT1"];
            elseif (n==2) then
                return U.Locations["RBT2"];
            elseif (n==3) then
                return U.Locations["RBT3"];
            end
        end
    elseif(side==1) then
        if (lane==LANE_TOP) then
            if (n==1) then
                return U.Locations["DTT1"];
            elseif (n==2) then
                return U.Locations["DTT2"];
            elseif (n==3) then
                return U.Locations["DTT3"];
            end
        elseif (lane==LANE_MID) then
            if (n==1) then
                return U.Locations["DMT1"];
            elseif (n==2) then
                return U.Locations["DMT2"];
            elseif (n==3) then
                return U.Locations["DMT3"];
            end
        elseif (lane==LANE_BOT) then
            if (n==1) then
                return U.Locations["DBT1"];
            elseif (n==2) then
                return U.Locations["DBT2"];
            elseif (n==3) then
                return U.Locations["DBT3"];
            end
        end
    end
    return nil;
end

function U.GetLaneTower(team, lane, i)
    if i > 3 and i < 6 then
        return GetTower(team, 5 + i)
    end

    local j = i - 1
    if lane == LANE_MID then
        j = j + 3
    elseif lane == LANE_BOT then
        j = j + 6
    end

    if j < 9 and j > -1 and (lane == LANE_BOT or lane == LANE_MID or lane == LANE_TOP) then
        return GetTower(team, j)
    end

    return nil
end

function U.Fountain(team)
    if team==TEAM_RADIANT then
        return Vector(-7093,-6542);
    end
    return Vector(7015,6534);
end

-------------------------------------------------------------------------------
-- Creep Functions
-------------------------------------------------------------------------------

-- returns a VECTOR() with location being the center point of provided creep array
function U.GetCenterOfCreeps(creeps)
    local center=Vector(0,0);
    local n=0.0;
    local meleeW=2;
    if creeps==nil or #creeps==0 then
        return nil;
    end

    for _,creep in pairs(creeps) do
        if (string.find(creep:GetUnitName(),"melee")~=nil) then
            center = center + (creep:GetLocation())*meleeW;
            n=n+meleeW;
        else
            n=n+1;
            center = center + creep:GetLocation();
        end
    end
    if n==0 then
        return nil;
    end
    center=center/n;

    return center;
end

function U.CreepGC()
    local swp_table = {}
    for handle,time_health in pairs(self["creeps"])
    do
        local rm = false;
        for t,_ in pairs(time_health)
        do
            if(GameTime() - t > 60) then
                rm = true;
            end
            break;
        end
        if not rm then
            swp_table[handle] = time_health;
        end
    end

    U.creeps = swp_table;
end

function U.UpdateCreepHealth(creep)
    if U.creeps == nil then
        U.creeps = {};
    end

    if(U.creeps[creep] == nil) then
        U.creeps[creep] = {};
    end
    if(creep:GetHealth() < creep:GetMaxHealth()) then
        U.creeps[creep][GameTime()] = creep:GetHealth();
    end

    if(#U.creeps > 1000) then
        self:CreepGC();
    end
end

function U.GetCreepHealthDeltaPerSec(creep)
    if U.creeps == nil then
        U.creeps = {};
    end

    if(U.creeps[creep] == nil) then
        return 0;
    else
        for _time,_health in U.PairsByKeys(U.creeps[creep],U.SortFunc) do
            -- only Consider very recent datas
            if(GameTime() - _time < 3) then
                local e = (_health - creep:GetHealth()) / (GameTime() - _time);
                return e;
            end
        end
        return 0;
    end
end

-- takes a "RANGE", returns creep handle and health value of that creep
function U.GetWeakestCreep(creeps)
    local WeakestCreep = nil
    local LowestHealth = 100000

    for _,creep in pairs(creeps) do
        U.UpdateCreepHealth(creep)
        if creep:IsAlive() then
            if creep:GetHealth() < LowestHealth then
                LowestHealth = creep:GetHealth()
                WeakestCreep = creep
            end
        end
    end

    return WeakestCreep, LowestHealth
end

-------------------------------------------------------------------------------
-- Functions for Offense & Defense
-------------------------------------------------------------------------------

function U.IsHeroAttackingMe(hero, fTime)
    if (hero == nil) or (not hero:IsAlive()) then return false end

    local fTime = fTime or 2.0
    local npcBot = GetBot()

    if npcBot:WasRecentlyDamagedByHero(hero, fTime) then
        return true
    end
    return false
end

function U.IsAnyHeroAttackingMe(fTime)
    local fTime = fTime or 2.0
    local npcBot = GetBot()

    if npcBot:WasRecentlyDamagedByAnyHero(fTime) then
        return true
    end
    return false
end

function U.IsTowerAttackingMe(fTime)
    local fTime = fTime or 1.0
    local npcBot = GetBot()

    if npcBot:WasRecentlyDamagedByTower(fTime) then
        return true
    end
    return false
end

function U.IsCreepAttackingMe(fTime)
    local fTime = fTime or 1.0
    local npcBot = GetBot()

    if npcBot:WasRecentlyDamagedByCreep(fTime) then
        return true
    end
    return false
end

-- returns a VECTOR() with location being the center point of provided hero array
function U.GetCenter(Heroes)
    if Heroes == nil or #Heroes == 0 then
        return nil
    end

    local sum = Vector(0.0, 0.0)
    local hn = 0.0

    for _,hero in pairs(Heroes) do
        if not hero:IsNull() and hero:IsAlive() then
            sum = sum + hero:GetLocation()
            hn = hn + 1
        end
    end
    return sum/hn
end

-- takes a "RANGE", returns hero handle and health value of that hero
-- FIXME - make it handle heroes that went invisible if we have detection
function U.GetWeakestHero(bot, r, heroList)
    local EnemyHeroes = heroList or bot:GetNearbyHeroes(r, true, BOT_MODE_NONE)

    if EnemyHeroes == nil or #EnemyHeroes == 0 then
        return nil, 10000
    end

    local WeakestHero = nil
    local LowestHealth = 10000

    for _, hero in ipairs(EnemyHeroes) do
        if GetUnitToUnitDistance(bot, hero) <= r and hero:IsAlive() then
            if hero:GetHealth() < LowestHealth then
                LowestHealth = hero:GetHealth()
                WeakestHero = hero
            end
        end
    end

    return WeakestHero, LowestHealth
end

function U.EnemyHasBreakableBuff(enemy)
    if enemy:IsNull() then return false end

    if enemy:HasModifier("modifier_clarity_potion") or
        enemy:HasModifier("modifier_flask_healing") or
        enemy:HasModifier("modifier_bottle_regeneration") then
        return true
    end
    return false
end

function U.UseOrbEffect(bot, enemy)
    local enemy = enemy or nil
    local orb = getHeroVar("HasOrbAbility")
    if orb ~= nil then
        local ability = bot:GetAbilityByName(orb)
        if ability ~= nil and ability:IsFullyCastable() then
            if enemy == nil then
                enemy, _ = U.GetWeakestHero(bot, ability:GetCastRange()+100)
            end

            if enemy ~= nil then
                U.TreadCycle(bot, constants.INTELLIGENCE)
                bot:Action_UseAbilityOnEntity(ability, enemy)
                return true
            end
        end
    end
    return false
end

function U.GetEnemyHeroFromId( id )
    local enemyList = GetUnitList(UNIT_LIST_ENEMY_HEROES)
    for _, enemy in pairs(enemyList) do
        if enemy:GetPlayerID() == id then
            return enemy
        end
    end
    return nil
end

function U.IsTargetMagicImmune(target)
    return target:IsInvulnerable() or target:IsMagicImmune()
end

function U.IsCrowdControlled(enemy)
    return enemy:IsRooted() or enemy:IsHexed() or enemy:IsStunned() or enemy:IsNightmared()
end

-------------------------------------------------------------------------------
-- Item & Courier Functions
-------------------------------------------------------------------------------

function U.NumberOfItems(bot)
    local n = 0

    for i = 0, 5, 1 do
        local item = bot:GetItemInSlot(i)
        if item ~= nil then
            n = n+1
        end
    end

    return n
end

function U.NumberOfItemsInBackpack(bot)
    local n = 0

    for i = 6, 8, 1 do
        local item = bot:GetItemInSlot(i)
        if item ~= nil then
            n = n+1
        end
    end

    return n
end

function U.NumberOfItemsInStash(bot)
    if bot:GetStashValue() == 0 then return 0 end

    local n = 0

    for i = 9, 14, 1 do
        local item = bot:GetItemInSlot(i)
        if item ~= nil then
            n = n+1
        end
    end

    return n
end

function U.HaveItem(bot, item_name)
    local slot = bot:FindItemSlot(item_name)
    if slot ~= ITEM_SLOT_TYPE_INVALID then
        local slot_type = bot:GetItemSlotType(slot)
        if slot_type == ITEM_SLOT_TYPE_MAIN then
            return bot:GetItemInSlot(slot)
        elseif slot_type == ITEM_SLOT_TYPE_BACKPACK then
            return U.MoveItemsFromBackpackToInventory(bot, slot)
        elseif slot_type == ITEM_SLOT_TYPE_STASH then
            if bot:HasModifier("modifier_fountain_aura") then
                if U.NumberOfItems(bot) < 6 then
                    U.MoveItemsFromStashToInventory(bot)
                    return U.HaveItem(bot, item_name)
                else
                    U.myPrint("FIXME: Implement swapping STASH to MAIN INVENTORY of item: ", item_name)
                end
            end
            return nil
        else
            U.myPrint("ERROR: condition should not be hit: ", item_name)
        end
    end

    return nil
end

function U.MoveItemsFromBackpackToInventory(bot, bpSlot)
    if U.NumberOfItems(bot) < 6 then
        for i = 0, 5, 1 do
            if bot:GetItemInSlot(i) == nil then
                bot:ActionImmediate_SwapItems(i, bpSlot)
                return bot:GetItemInSlot(i)
            end
        end
    else
        local bpItem = bot:GetItemInSlot(bpSlot)
        if bpItem:GetName() == "item_tpscroll" or bpItem:GetName() == "item_tome_of_knowledge" then
            bot:ActionImmediate_SwapItems(5, bpSlot)
            return bot:GetItemInSlot(5)
        else
            U.myPrint("FIXME: Implement swapping BACKPACK to MAIN INVENTORY of item: ", bpItem:GetName())
            return nil
        end
    end
    return nil
end

function U.MoveItemsFromStashToInventory(bot)
    if U.NumberOfItems(bot) == 6 and U.NumberOfItemsInBackpack(bot) == 3 then return end
    if U.NumberOfItemsInStash(bot) == 0 then return end

    for i = 0, 5, 1 do
        if bot:GetItemInSlot(i) == nil then
            for j = 9, 14, 1 do
                local item = bot:GetItemInSlot(j)
                if item ~= nil then
                    bot:ActionImmediate_SwapItems(i, j)
                end
            end
        end
    end

    for i = 6, 8, 1 do
        if bot:GetItemInSlot(i) == nil then
            for j = 9, 14, 1 do
                local item = bot:GetItemInSlot(j)
                if item ~= nil then
                    bot:ActionImmediate_SwapItems(i, j)
                end
            end
        end
    end
end

function U.GetFreeSlotInBackPack(bot)
    for i = 6, 8, 1 do
        if bot:GetItemInSlot(i) == nil then
            return i
        end
    end
    return -1
end

function U.HaveTeleportation(npcBot)
    if U.GetHeroName(npcBot) == "furion" then
        return true
    end

    if U.HaveItem(npcBot, "item_tpscroll") ~= nil
        or U.HaveItem(npcBot, "item_travel_boots_1") ~= nil
        or U.HaveItem(npcBot, "item_travel_boots_2") ~= nil then
        return true
    end
    return false
end

function U.GetTeleportationAbility(npcBot)
    if U.GetHeroName(npcBot) == "furion" then
        local ability = npcBot:GetAbilityByName("furion_teleportation")
        if ability ~= nil and ability:IsFullyCastable() then
            return ability
        end
    end

    local tp = U.HaveItem(npcBot, "item_tpscroll")
    if tp ~= nil and tp:IsFullyCastable() then
        return tp
    end
end

function U.IsItemAvailable(item_name)
    local npcBot = GetBot();

    local item = U.HaveItem(npcBot, item_name)
    if item ~= nil then
        if item:IsFullyCastable() then
            return item
        end
    end
    return nil;
end

--important items for delivery
function U.HasImportantItem()
     local npcBot = GetBot()

    for i = 9, 14, 1 do
        local item = npcBot:GetItemInSlot(i)
        if item ~= nil then
            if string.find(item:GetName(),"recipe") ~= nil or string.find(item:GetName(),"item_boots") ~= nil or string.find(item:GetName(),"item_bottle") then
                return true
            end

            if(item:GetName()=="item_ward_observer" and item:GetCurrentCharges() > 1) then
                return true
            end
        end
    end

    return false
end

function U.CourierThink(npcBot)
    if GetNumCouriers() == 0 then return end

    if npcBot:IsIllusion() then return end

    local checkLevel, newTime = U.TimePassed(getHeroVar("LastCourierThink"), 1.0)

    if not checkLevel then return end
    setHeroVar("LastCourierThink", newTime)

    local courier = GetCourier(0)
    if GetCourierState(courier) ~= COURIER_STATE_DEAD and GetCourierState(courier) ~= COURIER_STATE_MOVING and GetCourierState(courier) ~= COURIER_STATE_AT_BASE then
        npcBot:ActionImmediate_Courier(courier, COURIER_ACTION_RETURN)
        return
    end

    if npcBot:IsAlive() and (npcBot:GetStashValue() > 500 or npcBot:GetCourierValue() > 0 or U.HasImportantItem()) and GetCourierState(courier) == COURIER_STATE_AT_BASE then
        npcBot:ActionImmediate_Courier(courier, COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS)
        return
    end

    if GetCourierState(courier) ~= COURIER_STATE_DEAD and GetCourierState(courier) == COURIER_STATE_AT_BASE and
        (not npcBot:IsAlive()) and npcBot:GetCourierValue() > 0 then
        npcBot:ActionImmediate_Courier(courier, COURIER_ACTION_RETURN_STASH_ITEMS)
    end

    if GetCourierState(courier) == COURIER_STATE_DELIVERING_ITEMS or GetCourierState(courier) == COURIER_STATE_RETURNING_TO_BASE then
        npcBot:ActionImmediate_Courier(GetCourier(0), COURIER_ACTION_BURST)
    end
end

function U.GetNearestTree(npcBot)
    local trees = npcBot:GetNearbyTrees(700)

    for _, tree in ipairs(trees) do
        local treeLoc = GetTreeLocation(tree)
        --U.myPrint("Tree Loc: <", treeLoc[1], ", ", treeLoc[2], ", ", treeLoc[3], ">")
        if U.GetHeightDiff(npcBot, treeLoc[3]) == 0 then
            return tree
        end
    end
end

-------------------------------------------------------------------------------

function U.myPrint(...)
    local args = {...}
    local botname = U.GetHeroName(GetBot())
    local msg = tostring(U.Round(GameTime(), 3)).." [" .. botname .. "]: "
    for i,v in ipairs(args) do
        msg = msg .. tostring(v)
    end
    --uncomment to only see messages by bots mentioned underneath
    --if botname == "invoker" then --or botname == "viper" then
      print(msg)
    --end
end

return U;
