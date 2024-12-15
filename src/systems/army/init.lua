local config = require("src/config")
local protos = require("src/systems/army/proto")


local function create_squadron(unit_proto, name)
    return SQUADRON
        :New(unit_proto.BASE, unit_proto.SIZE, name)
        :SetGrouping(unit_proto.GROUP)
        :AddMissionCapability(unit_proto.CAPABILITY)
        :SetMissionRange(250)
        :SetDespawnAfterLanding(true)
        :SetFuelLowRefuel(true)
end

local function create_airwing(warehouseName, name, unit_protos)
    local airwing = AIRWING:New(warehouseName, name)
    if config.debug then
        -- airwing:SetMarker(true)
        -- airwing:SetDebugOn()
        -- airwing:ShowPatrolPointMarkers(true)
        airwing:SetTakeoffAir()
    end

    airwing:SetNumberCAP(2)
    airwing:SetNumberAWACS(1)
    airwing:SetCapCloseRaceTrack(true)
    airwing:SetRespawnAfterDestroyed(120)

    for unit_name, unit_proto in pairs(unit_protos) do
        airwing:AddSquadron(create_squadron(unit_proto, name .. " " .. unit_name))

        for key, value in pairs(unit_proto.PAYLOADS) do
            airwing:NewPayload(key, -1, value)
        end
    end

    return airwing
end

local function create_chief()
    local side = coalition.side.RED

    local intelProviders = SET_GROUP
        :New()
        :FilterCoalitions(side)
        :FilterStart()

    local chief = CHIEF:New(side, intelProviders, side)
    if config.debug then
        chief:SetVerbosity(3)
        chief:SetTacticalOverviewOn()
        chief:SetClusterAnalysis(true, true, true)
    end

    chief:SetAirToAir()
    chief:SetStrategy(CHIEF.Strategy.DEFENSIVE)

    chief:SetResponseOnTarget(2, 2, 0, TARGET.Category.AIRCRAFT)

    -- setup utis
    chief:AddAirwing(
        create_airwing("Sayqal Warehouse", "Sayqal", {protos.RED.MIG21, protos.RED.MIG23}))
    chief:AddAirwing(
        create_airwing("Palmyra Warehouse", "Palmyra", {protos.RED.MIG21}))

    -- setup borders and chief zones
    SET_ZONE
        :New()
        :FilterPrefixes("RED CAP")
        :FilterOnce()
        :ForEachZone(function (zone)
            -- TODO: fetch zone props
            chief:AddCapZone(zone)
        end)

    chief:AddBorderZone(ZONE_POLYGON:NewFromGroupName("Syria"))
    chief:AddConflictZone(ZONE_POLYGON:NewFromGroupName("Israel"))
    chief:AddConflictZone(ZONE_POLYGON:NewFromGroupName("Liban South"))

    -- WARN: delayed start
    chief:Start()

    return chief
end


return create_chief()