S_CTLD = CTLD:New(
    coalition.side.BLUE,
    {"Rotary", "Hercules"},
    "7th Transportation Brigade"
)

S_CTLD.verbose = 3
S_CTLD.dropAsCargoCrate = false
-- start: CH-47 support
S_CTLD.basetype = "ammo_cargo"
S_CTLD.forcehoverload = false -- no hover autoload, leads to cargo complications with ground crew created cargo items
S_CTLD.pilotmustopendoors = false -- crew must open back loading door 50% (horizontal) or more
S_CTLD.enableslingload = true -- will set cargo items as sling-loadable
S_CTLD.enableChinookGCLoading = true -- will effectively suppress the crate load and drop menus for CTLD for the Chinook
S_CTLD.movecratesbeforebuild = false -- cannot detect movement of crates at the moment
S_CTLD.nobuildinloadzones = true -- don't build where you load.
-- end: CH-47 support

-- S_CTLD:TraceOn()
S_CTLD:Start()


-- start: crates setup
S_CTLD:AddTroopsCargo("Infantry", {"#Infantry"}, CTLD_CARGO.Enum.TROOPS, 10, 100, 0)
S_CTLD:AddCratesCargo("Humvee", {"#Humvee"}, CTLD_CARGO.Enum.VEHICLE, 1, 2900, 0)

-- end: crates setup

return S_CTLD
