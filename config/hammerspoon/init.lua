-- Load modules
require("ime")
require("window")
require("apps")
require("cursor")

-- Auto-reload configuration on .lua file changes
local function reloadConfig(files)
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload()
            return
        end
    end
end

local configWatcher = hs.pathwatcher.new(hs.configdir, reloadConfig):start()

-- Caffeine: Toggle sleep prevention from menu bar
local caffeine = hs.menubar.new()

local function setCaffeineDisplay(state)
    if state then
        caffeine:setIcon(hs.image.imageFromName("NSStatusAvailable"))
        caffeine:setTooltip("Caffeine: ON (sleep prevented)")
    else
        caffeine:setIcon(hs.image.imageFromName("NSStatusNone"))
        caffeine:setTooltip("Caffeine: OFF")
    end
end

local function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

hs.alert.show("Config loaded")
