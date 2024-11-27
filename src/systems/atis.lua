local config = require("src/config")


local airports = {
    [AIRBASE.Syria.Ramat_David] = {
        ["atc_freq"] = 251.3,
        ["atis_freq"] = 121.4,
        ["active_runway"] = "33",
    },
}

local instances = {}

local function setup_atis(name, params)
    local atis = ATIS:New(name, params["atis_freq"])

    atis:SetTransmitOnlyWithPlayers(true)
    atis:SetMapMarks(true)
    atis:SetSRS(config.srs_path, "male", "en-US")
    atis:SetActiveRunway(params["active_runway"])
    atis:SetTowerFrequencies(params["atc_freq"])
    atis:Start()

    instances[name] = atis
end

local function setup_service ()
    for name, params in pairs(airports) do
        setup_atis(name, params)
    end
end

do
    setup_service()
end