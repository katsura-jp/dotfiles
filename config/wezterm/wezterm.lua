local wezterm = require 'wezterm'
local act = wezterm.action

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

-- Show indicator when Ctrl+B key table or leader is active
wezterm.on('update-status', function(window, pane)
  local key_table = window:active_key_table()
  local leader = window:leader_is_active()
  local indicator = ''
  if leader then
    indicator = wezterm.format {
      { Foreground = { Color = '#b4f9f8' } },
      { Background = { Color = '#414868' } },
      { Text = ' LEADER ' },
    }
  elseif key_table then
    indicator = wezterm.format {
      { Foreground = { Color = '#b4f9f8' } },
      { Background = { Color = '#414868' } },
      { Text = ' ' .. key_table .. ' ' },
    }
  end
  window:set_left_status(indicator)
end)

wezterm.on('update-right-status', function(window, pane)
  local cells = {}

  -- 1. workspace name
  local workspace = window:active_workspace()
  table.insert(cells, workspace)

  -- 2. date/time
  local date = wezterm.strftime '%F %H:%M'
  table.insert(cells, date)

  -- 3. battery percentage
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    '#414868',
    '#565f89',
    '#663a82',
    '#7c5295',
    '#b491c8',
  }

  -- Foreground color for the text across the fade
  local text_fg = '#b4f9f8'

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  local function push(text)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = colors[cell_no] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    num_cells = num_cells + 1
  end

  table.insert(elements, { Background = { Color = '#333333' } })
  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell)
  end

  window:set_right_status(wezterm.format(elements))
end)


wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    -- tokyo night color
    local background = '#24283b'
    local foreground = '#cfc9c2'

    if tab.is_active then
      background = '#414868'
      foreground = '#b4f9f8'
    elseif hover then
      background = '#565f89'
      foreground = '#c0caf5'
    end

    local active_pane = tab.active_pane
    local title = active_pane.foreground_process_name:match('([^/\\]+)$') or active_pane.title
    title = wezterm.truncate_right(title, max_width)
    local tab_index = tab.tab_index
    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = tab_index .. ': ' .. title .. ' ' },
    }
  end
)

wezterm.on('toggle-opacity', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.window_background_opacity then
    overrides.window_background_opacity = 0.3
  else
    overrides.window_background_opacity = nil
  end
  window:set_config_overrides(overrides)
end)

return {
    -- Rendering
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',

    -- Nightly features
    window_content_alignment = {
        horizontal = 'Center',
        vertical = 'Center',
    },
    quick_select_remove_styling = true,
    show_close_tab_button_in_tabs = false,
    native_macos_fullscreen_mode = false,
    macos_fullscreen_extend_behind_notch = true,

    -- Scrollback
    scrollback_lines = 10000,

    -- Window padding
    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4,
    },

    -- Pane
    inactive_pane_hsb = {
        saturation = 0.7,
        brightness = 0.5,
    },

    -- Font
    window_frame = {
        font = wezterm.font { family = 'Moralerspace Neon', weight = 'Bold' },
        font_size = 20.0,
    },
    font = wezterm.font_with_fallback {
        'Moralerspace Neon',
        'Source Han Code JP',
        'Inconsolata',
        'JetBrains Mono',
    },
    font_size = 18.0,
    line_height = 1.2,

    -- Appearance
    color_scheme = 'tokyonight',
    audible_bell = 'Disabled',
    use_fancy_tab_bar = true,

    -- Quick Select patterns
    quick_select_patterns = {
        '[0-9a-f]{7,40}',        -- git hash
        '/[\\w./\\-]+',           -- file paths
        '[\\w.\\-]+@[\\w.\\-]+',  -- email addresses
    },

    -- Leader key (Ctrl+A, like tmux)
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },

    keys = {
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
        { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
        { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        { key = 'w', mods = 'SHIFT|CTRL', action = act.CloseCurrentPane { confirm = true } },

        -- Tab/Workspace list (like tmux prefix + w)
        { key = 'w', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|WORKSPACES' } },

        -- Pane split (Leader key)
        { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
        { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

        -- Pane navigation (Leader key)
        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
        { key = 'LeftArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'DownArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'UpArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

        -- Pane resize mode (Leader + r)
        { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable {
            name = 'resize_pane',
            one_shot = false,
            timeout_milliseconds = 3000,
        }},

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

        -- Ctrl+B: tmux-aware pseudo-leader
        { key = 'b', mods = 'CTRL', action = if_not_tmux(act.ActivateKeyTable {
            name = 'tmux_compat',
            one_shot = true,
            timeout_milliseconds = 1000,
        })},

        -- Misc
        { key = 'Enter', mods = 'SHIFT', action = act { SendString = '\x1b\r' } },
        { key = 'u', mods = 'CTRL', action = act.EmitEvent 'toggle-opacity' },
    },

    key_tables = {
        -- Ctrl+B pseudo-leader (same bindings as Ctrl+A leader)
        tmux_compat = {
            { key = '|', mods = 'SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
            { key = '-', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
            { key = 'z', action = act.TogglePaneZoomState },
            { key = 'x', action = act.CloseCurrentPane { confirm = true } },
            { key = 'h', action = act.ActivatePaneDirection 'Left' },
            { key = 'j', action = act.ActivatePaneDirection 'Down' },
            { key = 'k', action = act.ActivatePaneDirection 'Up' },
            { key = 'l', action = act.ActivatePaneDirection 'Right' },
            { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
            { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
            { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
            { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
            { key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
            { key = 'n', action = act.ActivateTabRelative(1) },
            { key = 'p', action = act.ActivateTabRelative(-1) },
            { key = 'w', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|WORKSPACES' } },
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
    },

    mouse_bindings = {
        -- Ctrl-click will open the link under the mouse cursor
        {
            event = { Up = { streak = 1, button = 'Left' } },
            mods = 'CTRL',
            action = act.OpenLinkAtMouseCursor,
        },
    },
}
