-- monitor and auto register SAM sites

-- contains air defence networks separated by countryID
local networks = {}


function SETUP_SAM()
    MESSAGE:New("Found new SAM site", 10, "DEBUG"):ToAll()
end

-- local myredmantis = MANTIS:New("myredmantis", "Liban_RED SAM", "Liban_RED EWR", nil, "red", true)
-- myredmantis:Debug(true)
-- myredmantis:__Start(10)