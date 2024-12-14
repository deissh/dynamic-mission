local config = require("src/config")


local tmpl = {
    CAP = {
        MIG21 = "#TMPL MIG-21 CAP",
        MIG23 = "#TMPL MIG-23 CAP"
    }
}

local function create_sayqal()
    local airwing = AIRWING:New(AIRBASE.Syria.Sayqal, "Sayqal Wing")
    if config.debug then
        -- airwing:SetMarker(true)
        -- airwing:SetDebugOn()
        -- airwing:ShowPatrolPointMarkers(true)
    end

    airwing:SetCapCloseRaceTrack(true)
    airwing:SetNumberCAP(3)
    airwing:SetRespawnAfterDestroyed(120)

    local mig21 = SQUADRON
        :New(tmpl.CAP.MIG21, 24, "MiG-21")
        :SetGrouping(2)
        :AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5})
        :SetMissionRange(250)

    local mig23 = SQUADRON
        :New(tmpl.CAP.MIG23, 24, "MiG-23")
        :SetGrouping(2)
        :AddMissionCapability({AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5})
        :SetMissionRange(250)

    airwing:AddSquadron(mig21)
    airwing:AddSquadron(mig23)
    airwing:NewPayload(tmpl.CAP.MIG21, -1, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5})
    airwing:NewPayload(tmpl.CAP.MIG23, -1, {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ALERT5})

    return airwing
end

local function create_chief()
    local intelProviders = SET_GROUP
        :New()
        :FilterCoalitions(coalition.side.RED)
        :FilterStart()

    local chief = CHIEF:New(coalition.side.RED, intelProviders, "RED")
    if config.debug then
        chief:SetVerbosity(3)
        chief:SetTacticalOverviewOn()
        chief:SetClusterAnalysis(true, true, true)
    end

    chief:SetAirToAir()
    chief:SetStrategy(CHIEF.Strategy.TOTALWAR)

    chief:SetResponseOnTarget(2, 2, 0, TARGET.Category.AIRCRAFT)

    -- setup utis
    chief:AddAirwing(create_sayqal())

    -- setup borders and cap zones
    SET_ZONE
        :New()
        :FilterPrefixes("RED CAP")
        :FilterOnce()
        :DrawZone()
        :ForEachZone(function (zone)
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