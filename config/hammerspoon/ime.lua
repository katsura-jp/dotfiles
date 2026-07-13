local config = require("config").ime

-- JIS Eisu/Kana keycodes (postable as events even on US layouts)
local EISU_KEYCODE = 102
local KANA_KEYCODE = 104

-- Use currentSourceID() for detection (currentLayout() always returns "ABC" even in Hiragana mode)
local function isEnglish()
    return hs.keycodes.currentSourceID() == config.englishSourceID
end

local function switchToEnglish()
    hs.eventtap.keyStroke({}, EISU_KEYCODE, 0)
    hs.alert.show(config.englishLayout, hs.styledtext, hs.screen.mainScreen(), config.alertDuration)
end

local function switchToHiragana()
    hs.eventtap.keyStroke({}, KANA_KEYCODE, 0)
    hs.alert.show(config.methods.hiragana.alert, hs.styledtext, hs.screen.mainScreen(), config.alertDuration)
end

-- Korean cannot be reached via Eisu/Kana keys; setMethod() with a retry
local function switchToKorean()
    hs.keycodes.setMethod(config.methods.korean.name)
    hs.alert.show(config.methods.korean.alert, hs.styledtext, hs.screen.mainScreen(), config.alertDuration)
    hs.timer.doAfter(0.1, function()
        if hs.keycodes.currentMethod() ~= config.methods.korean.name then
            hs.keycodes.setMethod(config.methods.korean.name)
        end
    end)
end

-- Ctrl+Space: Toggle English/Hiragana
hs.hotkey.bind({ "ctrl" }, "space", function()
    if isEnglish() then
        switchToHiragana()
    else
        switchToEnglish()
    end
end)

-- Ctrl+Shift+Space: Toggle Hiragana/Korean
hs.hotkey.bind({ "ctrl", "shift" }, "space", function()
    if hs.keycodes.currentMethod() == config.methods.korean.name then
        switchToHiragana()
    else
        switchToKorean()
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
