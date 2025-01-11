require("dependency/dct")
require("dependency/moose")

local config = require("src/config")

if config.debug then
    MESSAGE:New("Loaded dependencies", 10, "DEBUG"):ToAll()
end

require("src/traffic/rat")