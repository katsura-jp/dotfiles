local config = require("config").cursor

local function moveCursor(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if f.ctrl then
        local pos = hs.mouse.absolutePosition()
        local speed = config.speed
        if c == hs.keycodes.map["up"] then
            hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x, pos.y - speed))
        elseif c == hs.keycodes.map["down"] then
            hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x, pos.y + speed))
        elseif c == hs.keycodes.map["left"] then
            hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x - speed, pos.y))
        elseif c == hs.keycodes.map["right"] then
            hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x + speed, pos.y))
        end
    end
end

local moveCursorEvent = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, moveCursor)
moveCursorEvent:start()

hs.hotkey.bind({ "ctrl" }, "return", function()
    hs.eventtap.leftClick(hs.mouse.absolutePosition())
end)
