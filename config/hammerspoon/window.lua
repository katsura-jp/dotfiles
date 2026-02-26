local config = require("config")

hs.window.animationDuration = config.window.animationDuration

-- Resize window
local function resizeWindow(rect)
    local win = hs.window.focusedWindow()
    if win then win:move(rect) end
end

hs.hotkey.bind({ "cmd" }, "Up", hs.fnutils.partial(resizeWindow, hs.layout.maximized))
hs.hotkey.bind({ "cmd" }, "Right", hs.fnutils.partial(resizeWindow, hs.layout.right50))
hs.hotkey.bind({ "cmd" }, "Left", hs.fnutils.partial(resizeWindow, hs.layout.left50))

-- Move to next/previous screen
local function moveToNextScreen()
    local win = hs.window.focusedWindow()
    if win then
        win:moveToScreen(win:screen():next())
        win:maximize()
    end
end

local function moveToPrevScreen()
    local win = hs.window.focusedWindow()
    if win then
        win:moveToScreen(win:screen():previous())
        win:maximize()
    end
end

hs.hotkey.bind({ "shift", "cmd" }, "Right", moveToNextScreen)
hs.hotkey.bind({ "shift", "cmd" }, "Left", moveToPrevScreen)

-- Window switcher
local switcher = hs.window.switcher.new()
local ui = config.switcher
switcher.ui.showTitles = ui.showTitles
switcher.ui.showSelectedTitle = ui.showSelectedTitle
switcher.ui.showSelectedThumbnail = ui.showSelectedThumbnail
switcher.ui.thumbnailSize = ui.thumbnailSize
switcher.ui.backgroundColor = ui.backgroundColor

hs.hotkey.bind({ "alt" }, "tab", function() switcher:next() end)
hs.hotkey.bind({ "alt", "shift" }, "tab", function() switcher:previous() end)
hs.hotkey.bind({ "alt" }, "right", function() switcher:next() end)
hs.hotkey.bind({ "alt" }, "left", function() switcher:previous() end)
