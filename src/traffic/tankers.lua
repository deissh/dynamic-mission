local ARR_ZONE_PREFIX = "AAR_ZONE"

local function collect_aar_zones()
    return SET_ZONE
        :FilterPrefixes(ARR_ZONE_PREFIX)
end

local function create_tankers()
end

return create_tankers()