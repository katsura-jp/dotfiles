local config = require("config").apps

local function open(name)
    return function()
        hs.alert.show(name, hs.styledtext, hs.screen.primaryScreen(), 0.3)
        hs.application.launchOrFocus(name)
        if name == "Finder" then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

for _, app in ipairs(config) do
    hs.hotkey.bind({ "ctrl", "cmd" }, app.key, open(app.name))
end
