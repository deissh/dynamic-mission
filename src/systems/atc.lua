local config = require("src/config")


local airports = {
    [AIRBASE.Syria.Ramat_David] = {
        ["atc_freq"] = 251.3,
        ["atis_freq"] = 121.4,
    },
    [AIRBASE.Syria.Rosh_Pina] = {
        ["atc_freq"] = 251.3,
        ["atis_freq"] = 118.45,
    },
    [AIRBASE.Syria.Kiryat_Shmona] = {
        ["atc_freq"] = 251.3,
        ["atis_freq"] = 110.15,
    },
}

local atis_instances = {}
local atc_instances = {}

local function setup_atc(name, params)
    local atc = FLIGHTCONTROL:New(name, params["atc_freq"], nil, config.srs_path)
    atc:SetParkingGuardStatic("Static TAXI STOP")
    atc:SetATIS(atis_instances[name])
    atc:SetRadioOnlyIfPlayers(true)
    atc:Start()

    atc_instances[name] = atc
end

local function setup_atis(name, params)
    if !config.atis.enable then
        return
    end

    local atis = ATIS:New(name, params["atis_freq"])

    atis:SetTransmitOnlyWithPlayers(true)
    atis:SetMapMarks(true)
    atis:SetSRS(config.srs_path, "male", "en-US")
    atis:SetTowerFrequencies(params["atc_freq"])
    atis:Start()

    atis_instances[name] = atis
end

local function setup_service ()
    for name, params in pairs(airports) do
        setup_atis(name, params)
        setup_atc(name, params)
    end
end


setup_service()