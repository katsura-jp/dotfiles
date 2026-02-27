local config = require("config").ime

-- Use currentSourceID() for detection (currentLayout() always returns "ABC" even in Hiragana mode)
local function isEnglish()
    return hs.keycodes.currentSourceID() == config.englishSourceID
end

local function switchToEnglish()
    hs.keycodes.setLayout(config.englishLayout)
    hs.alert.show(config.englishLayout, hs.styledtext, hs.screen.mainScreen(), config.alertDuration)
end

local function switchToMethod(method)
    hs.keycodes.setMethod(method.name)
    hs.alert.show(method.alert, hs.styledtext, hs.screen.mainScreen(), config.alertDuration)
end

-- Ctrl+Space: Toggle English/Hiragana
hs.hotkey.bind({ "ctrl" }, "space", function()
    if isEnglish() then
        switchToMethod(config.methods.hiragana)
    else
        switchToEnglish()
    end
end)

-- Ctrl+Shift+Space: Toggle Hiragana/Korean
hs.hotkey.bind({ "ctrl", "shift" }, "space", function()
    if hs.keycodes.currentMethod() == config.methods.korean.name then
        switchToMethod(config.methods.hiragana)
    else
        switchToMethod(config.methods.korean)
    end
end)

-- Escape: Auto-switch to English (key is passed through to apps)
local escapeToEnglish
escapeToEnglish = hs.hotkey.new({}, "escape", function()
    if not isEnglish() then
        switchToEnglish()
    end
    escapeToEnglish:disable()
    hs.eventtap.keyStroke({}, "escape", 0)
    hs.timer.doAfter(0.15, function()
        escapeToEnglish:enable()
    end)
end)
escapeToEnglish:enable()

-- Ctrl+B: Auto-switch to English (key is passed through to WezTerm)
local ctrlbToEnglish
ctrlbToEnglish = hs.hotkey.new({ "ctrl" }, "b", function()
    if not isEnglish() then
        switchToEnglish()
    end
    ctrlbToEnglish:disable()
    hs.eventtap.keyStroke({ "ctrl" }, "b", 0)
    hs.timer.doAfter(0.15, function()
        ctrlbToEnglish:enable()
    end)
end)
ctrlbToEnglish:enable()
