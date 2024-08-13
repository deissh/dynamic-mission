--- Init warehouse params from table<string, string>
--- @param warehouse Functional.Warehouse#WAREHOUSE
--- @param props table<string, string>
local function fob_set_props(warehouse, props)
    for key, value in pairs(props) do
        if key == "air_connection" then
            local airbase = AIRBASE.FindByName(value)
            warehouse:SetAirbase(airbase)
        end
    
        if key == "road_connection" then
            warehouse:SetRoadConnection(
                ZONE:FindByName(value):GetCoordinate())
        end
    
        if key == "rail_connection" then
            warehouse:SetRailConnection(
                STATIC:FindByName(value):GetCoordinate())
        end

        if key == "spawn_zone" then
            warehouse:SetSpawnZone(
                ZONE:FindByName(value))
        end
    end
end

local function fob_set_ctld(warehouse)
    local zone = warehouse:GetWarehouseZone()

    S_CTLD:AddCTLDZone(
        zone:GetName(),
        CTLD.CargoZoneType.LOAD,
        SMOKECOLOR.Blue,
        true, -- active
        true  -- create beac
    )
end

local function init_fob(zone)
    local props = zone:GetAllProperties() --@type table<string, string>

    local main_static = STATIC:FindByName(props["warehouse"] or "")
    if main_static == "" then
        return nil
    end

    local warehouse = WAREHOUSE:New(main_static, props["name"])

    fob_set_props(warehouse, props)
    fob_set_ctld(warehouse)

    warehouse:SetWarehouseZone(zone)
    warehouse:SetMarker()
    warehouse:SetDebugOn()
    warehouse:Start()

    return warehouse
end

local function link_fob(zone)

end


local warehouses = {} --@type table<string, Functional.Warehouse#WAREHOUSE>

SET_ZONE
    :New()
    :FilterPrefixes("@FOB")
    :FilterOnce()
    :DrawZone()
    :ForEachZone(init_fob)

return warehouses