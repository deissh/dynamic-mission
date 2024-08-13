env.info( '*** DYNAMIC SCRIPT START *** ' )

local base = _G

BASE_SCRIPT_PATH = 'C:/Users/deissh/Saved Games/DCS.openbeta/Scripts/dynamic-mission/'

G_cache = {}

--- Load file from BASE_SCRIPT_PATH\
--- Example: require( 'src/somefile.lua' )
--- @param file string
function require( file )
	if not G_cache[file] == nil then
		return G_cache[file]
	end

	local path = BASE_SCRIPT_PATH .. file
	local f = assert( base.loadfile( path ) )

	if f == nil then
		error ("Script: Could not load file " .. path )
	else
		env.info( "Script: " .. path .. " dynamically loaded." )
		local value = f()

		G_cache[file] = value

		return value
	end
end


require( 'src/main.lua' )
