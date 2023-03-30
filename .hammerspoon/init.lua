hs.window.animationDuration = 0

-- key bind
local function toggleIME(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if c == hs.keycodes.map['space'] then
        if f.ctrl then
            if hs.keycodes.currentMethod() == 'Romaji' then
                hs.keycodes.setMethod('Hiragana')
                hs.alert.show("かな", hs.styledtext, hs.screen.mainScreen(), 0.2)
            else
                hs.keycodes.setMethod('Romaji')
                hs.alert.show("ABC", hs.styledtext, hs.screen.mainScreen(), 0.2)
            end
        end
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

eikana = hs.eventtap.new({hs.eventtap.event.types.keyUp}, toggleIME)
eikana:start()

escape2english = hs.eventtap.new({hs.eventtap.event.types.keyUp}, esc2eng)
escape2english:start()

-- window keybind
function resize_window(rect)
  local win = hs.window.focusedWindow()
  win:move(rect)
end
hs.hotkey.bind({"cmd"}, "Up", hs.fnutils.partial(resize_window, hs.layout.maximized))
hs.hotkey.bind({"cmd"}, "Right", hs.fnutils.partial(resize_window, hs.layout.right50))
hs.hotkey.bind({"cmd"}, "Left", hs.fnutils.partial(resize_window, hs.layout.left50))

function moveToNextScreen()
  local app = hs.window.focusedWindow()
  app:moveToScreen(app:screen():next())
  app:maximize()
end

function moveToPrevScreen()
  local app = hs.window.focusedWindow()
  app:moveToScreen(app:screen():previous())
  app:maximize()
end

hs.hotkey.bind({"shift", "cmd"}, "Right", moveToNextScreen)
hs.hotkey.bind({"shift", "cmd"}, "Left", moveToPrevScreen)

-- window swicher
switcher = hs.window.switcher.new()
switcher.ui.showTitles = false
switcher.ui.showSelectedTitle = false
switcher.ui.showSelectedThumbnail = false
switcher.ui.thumbnailSize = 256
switcher.ui.backgroundColor = {0.0,0.0,0.0,0.0}
hs.hotkey.bind({'alt'},'tab', function()switcher:next()end)
hs.hotkey.bind({'alt', 'shift'},'tab', function()switcher:previous()end)

-- shortcut
function open(name)
  return function()
    hs.alert.show(name, hs.styledtext, hs.screen.primaryScreen(), 0.3)
    hs.application.launchOrFocus(name)
    if name == 'Finder' then
      hs.appfinder.appFromName(name):activate()
    end
  end
end

hs.hotkey.bind({"ctrl", "cmd"}, '1', open("wezterm"))
hs.hotkey.bind({"ctrl", "cmd"}, '2', open("Visual Studio Code"))
hs.hotkey.bind({"ctrl", "cmd"}, '3', open("Google Chrome"))
hs.hotkey.bind({"ctrl", "cmd"}, '4', open("slack"))
