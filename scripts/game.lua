require("config")
require("framework.init")
require("framework.client.init")
require("common")

-- define global module
game = {}

function game.startup()
    
   
    
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)

    -- preload all sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end
    
   
   local data =  require("ParseJson").decode("/scripts/testjs")
   CCLuaLog("level="..tostring(data).."xx..............")
   local leve = data.level[52]
   CCLuaLog("level="..tostring(leve).."..............")
    CCLuaLog("dirr="..tostring(dirr).."..............")
    
    
    
    local ant = require("NetWork")
    local date,err = ant.connect("121.199.49.188",9999)
    ant.send("a",0.5,0)
    ant.receive(13,0.5,0)
    CCLuaLog("date="..tostring(date).."err="..tostring(err).."/n")
    
    game.enterChooseLevelScene()
   -- game.enterMenuScene()
    -- game.playLevel(1)
end

function game.exit()
    CCDirector:sharedDirector():endToLua()
end

function game.enterMenuScene()
    display.replaceScene(require("scenes.MenuScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.enterMoreGamesScene()
    display.replaceScene(require("scenes.MoreGamesScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.enterChooseLevelScene()
    display.replaceScene(require("scenes.ChooseLevelScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game.playLevel(levelIndex)
    local PlayLevelScene = require("scenes.PlayLevelScene")
    display.replaceScene(PlayLevelScene.new(levelIndex), "fade", 0.6, display.COLOR_WHITE)
end
