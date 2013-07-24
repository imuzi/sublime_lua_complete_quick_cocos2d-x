
local MenuScene = class("MenuScene", function()
    return display.newScene("MenuScene")
end)

function MenuScene:ctor()
    self.bg = display.newBackgroundSprite("#MenuSceneBg.png")
    self:addChild(self.bg)

    self.adBar = require("views.AdBar").new()
    self:addChild(self.adBar)

    -- create menu
    local BubbleButton = require("views.BubbleButton")
    self.moreGamesButton = BubbleButton.new({
        image = "#MenuSceneMoreGamesButton.png",
        x = display.left + 150,
        y = display.bottom + 300,
        sound = GAME_SFX.tapButton,
        prepare = function()
            --self.menu:setEnabled(false)
            self.layer:setKeypadEnabled(false)
        end,
        listener = function()
           -- game.enterMoreGamesScene()
        end,
    })
    
    

    self.startButton = BubbleButton.new({
        image = "#MenuSceneStartButton.png",
        imageDisabled = "#MenuSceneMoreGamesButton.png",
        x = display.right - 150,
        y = display.bottom + 300,
        sound = GAME_SFX.tapButton,
        prepare = function()
            --self.menu:setEnabled(false)
            self.layer:setKeypadEnabled(false)
        end,
        listener = function()
            --game.enterChooseLevelScene()
        end,
    })
    
    local function toggleSwitch(tag,menuItem)
        local toggleItem = tolua.cast(menuItem,"CCMenuItemToggle")
        local nIndex     = toggleItem:getSelectedIndex()
        local selectedItem = toggleItem:selectedItem()
        if 0 == nIndex  then
            selectedItem = nil
            CCLuaLog("----nIndex0")
            else
            CCLuaLog("----nIndex1")

        end
        game.enterChooseLevelScene()
        --CCNotificationCenter:sharedNotificationCenter():postNotification(NotificationCenterParam.MSG_SWITCH_STATE,selectedItem)
    end
    
    local switchlabel1 = CCLabelTTF:create("switch off", "Marker Felt", 26)
    local switchlabel2 = CCLabelTTF:create("switch on", "Marker Felt", 26)
    local switchitem1  = CCMenuItemLabel:create(switchlabel1)
    local switchitem2 = CCMenuItemLabel:create(switchlabel2)
    local switchitem = CCMenuItemToggle:create(self.moreGamesButton)
    switchitem:addSubItem(self.startButton)
    switchitem:registerScriptTapHandler(toggleSwitch)
    --turn on
    switchitem:setSelectedIndex(1)
    
    
    
    local menu = CCMenu:create()
    menu:addChild(switchitem)
    menu:setPosition(ccp(display.right - 150,
                         display.bottom + 500))
    self:addChild(menu)
    
    
    
    --self.menu = ui.newMenu({self.moreGamesButton, self.startButton })
   -- self:addChild(self.menu)

    
    local function switchStateChanged()
        local nIndex = switchitem:getSelectedIndex()
        
        if 0 == nIndex then
            CCLuaLog("~~~~~~----nIndex0")
            else
            CCLuaLog("~~~~~~~~~----nIndex1")
        end
    end
 
    
    
    local function createLayerFarm()
        local layerFarm = CCLayer:create()
        
        local font = CCLabelTTF:create("Himi 使用tolua++ binding自定义类", "Verdana-BoldItalic", 20)
        font:setPosition(ccp(220,260))
        layerFarm:addChild(font)
        
        local ms  = MySprite:createMS("Icon.png")
        layerFarm:addChild(ms)
        
        return layerFarm
    end
    
    
    self:addChild(createLayerFarm())
    -- keypad layer, for android
    self.layer = display.newLayer()
    self.layer:addKeypadEventListener(function(event)
        if event == "back" then
            audio.playSound(GAME_SFX.backButton)
            game.exit()
        end
    end)
    self:addChild(self.layer)
end

function MenuScene:onEnter()
    -- avoid unmeant back
    self:performWithDelay(function()
        self.layer:setKeypadEnabled(true)
    end, 0.5)
end

return MenuScene
