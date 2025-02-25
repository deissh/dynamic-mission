local protos = {
    PLANE = {
        {
            name = "#C-17A",
            min = 0,
            fl_min = 300,
            fl_max = 370,
        },
        {
            name = "#C-130",
            min = 1,
            fl_min = 300,
            fl_max = 370,
        },
    },
    HELI = {
        {
            name = "#CH-47D",
            min = 2,
        },
        {
            name = "#UH-60",
            min = 2,
        },
        {
            name = "#OH-58D",
            min = 1,
        }
    }
}

local function create_heli()
    local manager = RATMANAGER:New(8)

    for idx, template in ipairs(protos.HELI) do
        local inst = RAT
            :New(template.name, template.name .. "-" .. idx)
            :SetCoalitionAircraft("blue")
            :SetCoalition("sameonly")
            :AddFriendlyAirportsToDestinations()
            :AddFriendlyAirportsToDepartures()
            :SetMaxDistance(200)
            :Commute(true)
            :EnableATC(false)

        manager:Add(inst, template.min)
    end

    return manager:Start(10)
end

local function create_plane()
    local manager = RATMANAGER:New(3)
    local zones = {
        "SPAWN_ZONE-1",
        "SPAWN_ZONE-2"
    }

    for idx, template in ipairs(protos.PLANE) do
        local inst = RAT
            :New(template.name, template.name .. "-" .. idx)
            -- :SetTakeoff("air")
            -- :RespawnInAirAllowed()
            -- :RespawnInAirNotAllowed()
            :SetCoalitionAircraft("blue")
            :SetCoalition("sameonly")
            :SetDeparture(zones)
            :SetDestination(zones)
            :AddFriendlyAirportsToDestinations()
            :AddFriendlyAirportsToDepartures()
            :Commute(true)
            :EnableATC(false)

        manager:Add(inst, template.min)
    end

    return manager:Start(10)
end

local function create_rat()
    create_plane()
    create_heli()
end

return create_rat()
