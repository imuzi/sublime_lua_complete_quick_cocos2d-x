
local PlayLevelScene = class("PlayLevelScene", function()
    return display.newScene("PlayLevelScene")
end)

function PlayLevelScene:ctor(levelIndex)
    
    self.layer = display.newLayer()
    self.layer:setTouchEnabled(true)

    
    local bg = display.newSprite("#PlayLevelSceneBg.png")
    -- make background sprite always align top
    bg:setPosition(display.cx, display.top - bg:getContentSize().height / 2)
    self.layer:addChild(bg)

    local title = display.newSprite("#Title.png", display.left + 150, display.top - 50)
    title:setScale(0.5)
    self.layer:addChild(title)

    local label = ui.newBMFontLabel({
        text  = string.format("Level: %s", tostring(levelIndex)),
        font  = "UIFont.fnt",
        x     = display.left + 10,
        y     = display.bottom + 40,
        align = ui.TEXT_ALIGN_LEFT,
    })
    self.layer:addChild(label)

    local Levels = require("data.Levels")
    local levelData = Levels.get(levelIndex)

    -- keypad layer, for android
       
    local menuitem = ui.newImageMenuItem({
                                     image = "#BackButton.png",
                                     imageSelected = "#BackButtonSelected.png",
                                     x = display.left + 100,
                                     y = display.top - 120,
                                     sound = GAME_SFX.backButton,
                                     listener = function()
                                     self:backToMenuScene()
                                     end,
    
                            })
    local menu = ui.newMenu({menuitem})
    self.layer:addChild(menu)
    
    --self.layer:addKeypadEventListener(function(event)
     --   if event == "back" then
     --       audio.playSound(GAME_SFX.backButton)
    --        self.layer:setKeypadEnabled(false)
     --       game.enterChooseLevelScene()
    --    end
   -- end)
    
   -- self.layer:setTouchEnabled(true)
   -- self.layer:addTouchEventListener(function(event, x, y)
   --                                 return self:onTouch(event, x, y)
--end)
    self:addChild(self.layer)
    menu:setEnabled(false)
    --require("framework.client.api.EventProtocol").extend(self.layer)
    local function onTouchBegan(x, y)
       
                    CCLuaLog("xxgedte")
        
        
        --self:backToMenuScene()
        -- CCTOUCHBEGAN event must return true
        return true
    end
    
    local function onTouchMoved(x, y)
       -- self:backToMenuScene()
        CCLuaLog("moverd")

        
    end
    
    local function onTouchEnded(x, y)
        -- self:backToMenuScene()
        CCLuaLog("ended")
        
        
    end
    
    local function onTouch(eventType, x, y)
        if eventType == "began" then
            CCLuaLog("xxontouchbegan")
            return onTouchBegan(x, y)
            elseif eventType == "moved" then
            CCLuaLog("xxontouchmoved")
            menu:setEnabled(true)
            return onTouchMoved(x, y)
            elseif eventType == "ended" then
            CCLuaLog("xxontouchmoved")
            menu:setEnabled(true)
            return onTouchEnded(x, y)
        end
    end
    
   self.layer:registerScriptTouchHandler(onTouch)
   

end

function PlayLevelScene:onEnter()
    -- avoid unmeant back
    self:performWithDelay(function()
        self.layer:setKeypadEnabled(true)
    end, 0.5)
end





function PlayLevelScene:onTouchBegan(x, y)
    CCLuaLog("---------------oobegan")
    return true
end

function PlayLevelScene:onTouchMoved(x, y)
    CCLuaLog("---------------oobegan")
    return true
end

function PlayLevelScene:onTouchEnded(x, y)
    CCLuaLog("---------------oobegan")
    return true
end

function PlayLevelScene:onTouchCanceled(x, y)
    CCLuaLog("---------------oobegan")
    return true
end

function PlayLevelScene:onTouch(event, x, y)
   
    if event == "began" then
        CCLuaLog("---------------began")
        return self:onTouchBegan(x, y)
        elseif event == "moved" then
        CCLuaLog("---------------moved")
        self:onTouchMoved(x, y)
        elseif event == "ended" then
        CCLuaLog("---------------ended")
       self:onTouchEnded(x, y)
        else -- cancelled
       -- self:onTouchCancelled(x, y)
    end
    
end

function PlayLevelScene:backToMenuScene()
    display.replaceScene(require("scenes.MenuScene").new(), "fade", 0.6, display.COLOR_WHITE)
end


return PlayLevelScene
