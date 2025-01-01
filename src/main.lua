-- FileSystem Tester (FSTester) by Joash Chee, Started on 2025

require "love-ansi"

love.filesystem.setIdentity("FSTester") -- for R36S file system compatibility

-- define global variables used in all scenes
bgart = {}
sfx = {}
help = {}


-- define global variables, used in input detection
triggerReport = ""
frameElapsed = 0 -- to check on love.update

-- input states [start]
dpadState = {}
fbtnState = {}
lstkState = {}
rstkState = {}
bbtnState = {}
miscState = {}
for i = 1,4 do
	dpadState[i] = ".."
	fbtnState[i] = ".."
	lstkState[i] = ".."
	rstkState[i] = ".."
	bbtnState[i] = ".."
	miscState[i] = ".."
end
-- L3 and R3 buttons added (requires manual edit on gptokeyb file on console)
miscState[5] = ".."
miscState[6] = ".."
-- input states [end]


-- load scene files here, global as the scenes use them when switching
scene = {}
scene[996] = require "scene-996" -- FSTester
scene[999] = require "scene-999" -- Exitscreen

scene.current = 996
scene.previous = 996



-- define local variables here [start]

local game = {} -- table for game data

game.tooltip = love.filesystem.getSaveDirectory( ) -- contextual tip at bottom bar

game.time = {} -- table for total time played
game.time.hours = 0
game.time.minutes = 0
game.time.seconds = 0

game.power = {} -- table for game power state
game.power.state, game.power.percent, game.power.timeleft = love.system.getPowerInfo( )

-- define variables here [end]


-- one-time setup of game / app, loading assets
function love.load()
	-- load fonts
    monoFont = love.graphics.newFont("JetBrainsMonoNL-Regular.ttf", 12)
	-- load autosaves
	if love.filesystem.getInfo( "game-time.txt" ) == nil then
		love.filesystem.newFile("game-time.txt")
		game.time = 0
		-- test file write
		local success, message =love.filesystem.write( "game-time.txt", game.time)
		if success then 
			game.tooltip = "file created"
		else 
			game.tooltip = "file not created: " .. message
		end
	else
		game.time = love.filesystem.read("game-time.txt")
	end
    -- initialise all scenes
	scene[996].init()
	scene[999].init()
end


-- load 1st scene input schema here
scene[scene.current].input()



-- callback for graceful exit
function love.quit()
  	-- autosave all data
  	game.time = math.floor(game.time + love.timer.getTime())
	love.filesystem.write( "game-time.txt", game.time )  	
end


-- to make game state changes frame-to-frame
function love.update(dt)
    frameElapsed = frameElapsed + 1

	-- run updates from scenes
	scene[996].update()

end


-- to render game state onto the screen, 60 fps
function love.draw()
	-- load scene draw state here
	if love.keyboard.isDown("escape") then
		love.graphics.draw(bgart[scene.current], 0, 0) -- draw regular scene background
	else
		love.graphics.draw(bgart[scene.current], 0, 0) -- draw regular scene background
	end
	scene[scene.current].draw()

end