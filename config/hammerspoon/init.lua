-- key bind
single_key_flag = true
single_key_timer = hs.timer.delayed.new(0.2, function()
    single_key_flag = false
end)

-- toggle on -> start true, stop true
-- toggle off -> start true, stop false
-- issue: start falseの場合がある
local function toggleIME(event)
	local c = event:getKeyCode()
	local f = event:getFlags()

	if not f['cmd'] and c == hs.keycodes.map['cmd'] then
        single_key_timer:stop()
        print("stop", single_key_flag)
        if single_key_flag then
            if hs.keycodes.currentMethod() == 'Romaji' then
                hs.keycodes.setMethod('Hiragana')
                hs.alert.show("かな", hs.styledtext, hs.screen.mainScreen(), 0.2)
            else
                hs.keycodes.setMethod('Romaji')
                hs.alert.show("ABC", hs.styledtext, hs.screen.mainScreen(), 0.2)
            end
        else
            single_key_flag = true
        end
    else
        single_key_flag = true
        single_key_timer:start()
        print("start", single_key_flag)
    end
end

local function esc2eng(event)
    local c = event:getKeyCode()
    if c == hs.keycodes.map['escape'] then
        if hs.keycodes.currentMethod() ~= 'Romaji' then
            hs.keycodes.setMethod('Romaji')
            hs.alert.show("ABC", hs.styledtext, hs.screen.mainScreen(), 0.2)
        end
    end
end

eikana = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, toggleIME)
eikana:start()

escape2english = hs.eventtap.new({hs.eventtap.event.types.keyUp}, esc2eng)
escape2english:start()
