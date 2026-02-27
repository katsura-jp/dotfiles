local wezterm = require 'wezterm'
local act = wezterm.action
local workspace = require 'workspace'

-- Ctrl+B: passthrough to tmux if running, otherwise execute WezTerm action
local function if_not_tmux(action)
  return wezterm.action_callback(function(window, pane)
    local process = pane:get_foreground_process_name() or ''
    if process:match('tmux') then
      window:perform_action(act.SendKey { key = 'b', mods = 'CTRL' }, pane)
    else
      window:perform_action(action, pane)
    end
  end)
end

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

    -- Ctrl+B: tmux-aware prefix
    { key = 'b', mods = 'CTRL', action = if_not_tmux(act.ActivateKeyTable {
        name = 'tmux_compat',
        one_shot = true,
        timeout_milliseconds = 1000,
    })},

    -- Misc
    { key = 'Enter', mods = 'SHIFT', action = act { SendString = '\x1b\r' } },
    { key = 'u', mods = 'CTRL', action = act.EmitEvent 'toggle-opacity' },
}

M.key_tables = {
    -- Ctrl+B prefix (tmux-compatible key bindings)
    tmux_compat = {
        { key = '|', mods = 'SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = '-', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'z', action = act.TogglePaneZoomState },
        { key = 'x', action = act.CloseCurrentPane { confirm = true } },
        { key = 'h', action = act.ActivatePaneDirection 'Left' },
        { key = 'j', action = act.ActivatePaneDirection 'Down' },
        { key = 'k', action = wezterm.action_callback(workspace.kill_workspace_selector) },
        { key = 'l', action = act.ActivatePaneDirection 'Right' },
        { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
        { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
        { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
        { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
        { key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'n', action = act.ActivateTabRelative(1) },
        { key = 'p', action = act.ActivateTabRelative(-1) },
        { key = 'w', action = wezterm.action_callback(workspace.show_workspace_tabs) },
        { key = 'r', action = act.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
            timeout_milliseconds = 3000,
        }},
    },
    resize_pane = {
        { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
        { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
        { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
        { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
        { key = 'Escape', action = 'PopKeyTable' },
    },
}

M.mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
}

return M
