local warehouses = {} --@type table<string, Functional.Warehouse#WAREHOUSE>

warehouses.TEST1 = WAREHOUSE:New(STATIC:FindByName("@Warehouse TEST1"), "TEST1")
warehouses.TEST2 = WAREHOUSE:New(STATIC:FindByName("@Warehouse TEST2"), "TEST2")

for _, warehouse in pairs(warehouses) do
    warehouse:AddAsset("#M939", 4)
    warehouse:AddAsset("#HMMWV", 4)
    warehouse:AddAsset("#Infantry", 10)

    warehouse:SetMarker(true)
    warehouse:SetReportOn()
    warehouse:Start()
end

-- warehouses.TEST1:AddRequest(
--     warehouses.TEST2,
--     WAREHOUSE.Descriptor.ATTRIBUTE,
--     WAREHOUSE.Attribute.GROUND_TRUCK,
--     WAREHOUSE.Quantity.ALL
-- )

local us = COMMANDCENTER:New(AIRBASE:FindByName(AIRBASE.Afghanistan.Camp_Bastion), "Camp Bastion")

return warehouses