local ARR_ZONE_PREFIX = "AAR_ZONE"

local function collect_aar_zones()
    return SET_ZONE
        :FilterPrefixes(ARR_ZONE_PREFIX)
end

local function create_tankers()
    local zones = collect_aar_zones()
end

return create_tankers()