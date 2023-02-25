local wezterm = require 'wezterm'
local act = wezterm.action

return {
    font = wezterm.font_with_fallback {
        'Inconsolata',
        'JetBrains Mono',
    },
    font_size = 24.0,
    color_scheme = "tokyonight",

    keys = {
        -- Quick Select
        { 
            key = ' ',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.QuickSelect
        },
        {
            key = 'P',
            mods = 'CTRL',
            action = wezterm.action.QuickSelectArgs {
                label = 'open url',
                patterns = {
                    'https?://\\S+',
                },
                action = wezterm.action_callback(function(window, pane)
                    local url = window:get_selection_text_for_pane(pane)
                    wezterm.log_info('opening: ' .. url)
                    wezterm.open_with(url)
                end),
            },
        },
        { key = '{', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
        { key = '}', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
        { key = "1", mods = 'ALT', action = act.ActivateTab(0) },
        { key = "2", mods = 'ALT', action = act.ActivateTab(1) },
        { key = "3", mods = 'ALT', action = act.ActivateTab(2) },
        { key = "4", mods = 'ALT', action = act.ActivateTab(3) },
        { key = "5", mods = 'ALT', action = act.ActivateTab(4) },
        { key = "6", mods = 'ALT', action = act.ActivateTab(5) },
        { key = "7", mods = 'ALT', action = act.ActivateTab(6) },
        { key = "8", mods = 'ALT', action = act.ActivateTab(7) },
        { key = "9", mods = 'ALT', action = act.ActivateTab(8) },
        { key = "0", mods = 'ALT', action = act.ActivateTab(-1) },
        {
            key = 'w',
            mods = 'SHIFT|CTRL',
            action = wezterm.action.CloseCurrentPane { confirm = true },
        },
    },
    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CTRL',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
    },
}
