require("dependency/dct")
require("dependency/moose")


local atc = FLIGHTCONTROL:New(AIRBASE.Afghanistan.Kandahar, 251, nil, "C:\\Program Files\\DCS-SimpleRadio-Standalone")
atc:SetParkingGuardStatic("Static TAXI STOP")
atc:Start()
