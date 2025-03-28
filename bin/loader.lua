do
    local modpath = lfs.writedir() .. "\\Missions\\dynamic-mission\\";

    if lfs.attributes(modpath) == nil then
        local errmsg = "Not found dynamic-mission folder in " .. modpath
        error(errmsg)
    end

    package.path = package.path .. ";" .. modpath .. "?.lua;"

    require("src/main")
end