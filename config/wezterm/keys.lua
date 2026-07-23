local wezterm = require 'wezterm'
local act = wezterm.action

-- Ctrl+B は WezTerm では奪わず、常にペイン内 (herdr / tmux) に渡す。
-- ペイン・タブ・workspace 管理は herdr 側 (prefix Ctrl+B) を使う。

local M = {}

M.keys = {
    -- Quick Select
    {
        key = ' ',
        mods = 'SHIFT|CTRL',
        action = act.QuickSelect,
    },
    {
        key = 'P',
        mods = 'CTRL',
        action = act.QuickSelectArgs {
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

    -- Tab navigation
    { key = '{', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(1) },
    { key = '1', mods = 'ALT', action = act.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = act.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = act.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = act.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = act.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = act.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = act.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = act.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = act.ActivateTab(8) },
    { key = '0', mods = 'ALT', action = act.ActivateTab(-1) },
    { key = 't', mods = 'CTRL', action = act.SpawnTab 'DefaultDomain' },
    { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentPane { confirm = true } },

    -- Workspace
    { key = 's', mods = 'ALT', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
    { key = 'n', mods = 'ALT', action = act.PromptInputLine {
        description = 'Enter workspace name',
        action = wezterm.action_callback(function(window, pane, line)
            if line then
                window:perform_action(act.SwitchToWorkspace { name = line }, pane)
            end
        end),
    }},

    -- Command palette
    { key = 'p', mods = 'SHIFT|ALT', action = act.ShowLauncherArgs {
        flags = 'FUZZY|TABS|WORKSPACES|COMMANDS|KEY_ASSIGNMENTS',
    }},

    -- Scroll
    { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollByLine(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },

    -- Misc
    -- CTRL+SHIFT+N (デフォルト SpawnWindow) は herdr の prefix+Shift+N と干渉するため無効化
    { key = 'N', mods = 'CTRL', action = act.DisableDefaultAssignment },
    { key = 'n', mods = 'SHIFT|CTRL', action = act.DisableDefaultAssignment },
    { key = 'Enter', mods = 'SHIFT', action = act { SendString = '\x1b\r' } },
    { key = 'u', mods = 'CTRL', action = act.EmitEvent 'toggle-opacity' },
}

M.key_tables = {}

M.mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
}

return M
