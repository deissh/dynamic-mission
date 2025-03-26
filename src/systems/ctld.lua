-- Make it global
g_CTLD = CTLD:New(
    coalition.side.BLUE,
    { "FOB", "Cargo" },
    "Cargo Ops"
)

g_CTLD.basetype = "container_cargo"
g_CTLD.dropcratesanywhere = true
g_CTLD.forcehoverload = false
g_CTLD.pilotmustopendoors = true
g_CTLD.enableslingload = true
g_CTLD.enableChinookGCLoading = true
g_CTLD.movecratesbeforebuild = false
g_CTLD.nobuildinloadzones = false
g_CTLD.ChinookTroopCircleRadius = 5

g_CTLD:Start()

g_CTLD:AddTroopsCargo("US Squad", { "#Squad" }, CTLD_CARGO.Enum.TROOPS, 3, 80)
g_CTLD:AddCratesCargo("Small Convoy", { "#Convoy" }, CTLD_CARGO.Enum.VEHICLE, 6)


function g_CTLD:OnAfterCratesBuild(From, Event, To, Group, Unit, Vehicle)
    MESSAGE:New("OnAfterCratesBuild", 10, "CTLD"):ToAll()
end

function g_CTLD:OnAfterCratesRepaired(From, Event, To, Group, Unit, Vehicle)
    MESSAGE:New("OnAfterCratesRepaired", 10, "CTLD"):ToAll()
end

SET_AIRBASE
    :New()
    :FilterCoalitions("blue")
    :FilterOnce()
    :ForEachAirbase(function(airbase)
        g_CTLD:AddCTLDZoneFromAirbase(
            airbase:GetName(),
            CTLD.CargoZoneType.LOAD,
            SMOKECOLOR.Blue, true, false
        )
        -- g_CTLD:AddCTLDZoneFromAirbase(
        --     airbase:GetName(),
        --     CTLD.CargoZoneType.DROP,
        --     SMOKECOLOR.Blue, true, false
        -- )
    end)
