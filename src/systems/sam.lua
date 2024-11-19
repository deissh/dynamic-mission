-- monitor and auto register SAM sites

-- contains air defence networks separated by countryID
local networks = {}

--- @param Wrapper.Group#GROUP
local function group_handler(group)
    MESSAGE:New("Found new SAM site", 10, "DEBUG"):ToAll()
end


SET_GROUP
    :New()
    :FilterPrefixes("n_sam")
    :ForEachGroupAlive(group_handler)
    :FilterStart()