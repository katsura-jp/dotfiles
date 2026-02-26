hs.window.animationDuration = 0

-- IME switching
-- Use currentSourceID() for detection (currentLayout() always returns "ABC" even in Hiragana mode)
local function isEnglish()
    return hs.keycodes.currentSourceID() == "com.apple.keylayout.ABC"
end

local function switchToEnglish()
    hs.keycodes.setLayout("ABC")
    hs.alert.show("ABC", hs.styledtext, hs.screen.mainScreen(), 0.2)
end

local function switchToMethod(method, alertText)
    hs.keycodes.setMethod(method)
    hs.alert.show(alertText, hs.styledtext, hs.screen.mainScreen(), 0.2)
end

hs.hotkey.bind({"ctrl"}, "space", function()
    if isEnglish() then
        switchToMethod('Hiragana', "かな")
    else
        switchToEnglish()
    end
end)

hs.hotkey.bind({"ctrl", "shift"}, "space", function()
    if hs.keycodes.currentMethod() == '2-Set Korean' then
        switchToMethod('Hiragana', "かな")
    else
        switchToMethod('2-Set Korean', "한글")
    end
end)

escape2english = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    if event:getKeyCode() == hs.keycodes.map['escape'] then
        if not isEnglish() then
            switchToEnglish()
        end
    end
end)
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

apps = {
  "wezterm",
  "Visual Studio Code",
  "Google Chrome",
  "slack",
  "Notion Calendar",
}

for i, name in pairs(apps) do
  hs.hotkey.bind({"ctrl", "cmd"}, tostring(i), open(name))
end

-- move cursor
function moveCursor(event)
  local c = event:getKeyCode()
  local f = event:getFlags()
  local speed = 15.0
  if f.ctrl then
    local pos = hs.mouse.absolutePosition()
    if c == hs.keycodes.map['up'] then
      hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x, pos.y - speed))
    end
    if c == hs.keycodes.map['down'] then
      hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x, pos.y + speed))
    end
    if c == hs.keycodes.map['left'] then
      hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x - speed, pos.y))
    end
    if c == hs.keycodes.map['right'] then
      hs.mouse.setAbsolutePosition(hs.geometry.point(pos.x + speed, pos.y))
    end
  end
end

moveCursorEvent = hs.eventtap.new({hs.eventtap.event.types.keyDown}, moveCursor)
moveCursorEvent:start()

hs.hotkey.bind({'ctrl'}, 'return', function()hs.eventtap.leftClick(hs.mouse.absolutePosition())end)
