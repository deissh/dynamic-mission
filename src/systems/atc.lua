local config = require("src/config")


local airports = {
    [AIRBASE.Afghanistan.Kandahar] = {
        ["atc_freq"] = 119.50,
        ["atis_freq"] = 125.50,
    },
}

local atis_instances = {}
local atc_instances = {}

local function setup_atc(name, params)
    local atc = FLIGHTCONTROL:New(name, params["atc_freq"], nil, config.srs_path)
    atc:SetParkingGuardStatic("#TMPL ATC Guard")
    atc:SetATIS(atis_instances[name])
    atc:SetRadioOnlyIfPlayers(true)
    atc:Start()

    atc_instances[name] = atc
end

local function setup_atis(name, params)
    local atis = ATIS:New(name, params["atis_freq"])

    atis:SetTransmitOnlyWithPlayers(true)
    atis:SetMapMarks(true)
    atis:SetSRS(config.srs_path, "male", "en-US")
    atis:SetTowerFrequencies(params["atc_freq"])
    atis:__Start(3)

    atis_instances[name] = atis
end

local function setup_service ()
    if config.atc == false then
        return atc_instances
    end

    for name, params in pairs(airports) do
        setup_atis(name, params)
        setup_atc(name, params)
    end

    return atc_instances
end

return setup_service()