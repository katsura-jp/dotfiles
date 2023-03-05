local wezterm = require 'wezterm'
local act = wezterm.action


wezterm.on('update-right-status', function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- 1. date/time
  local date = wezterm.strftime '%F %H:%M'
  table.insert(cells, date)

  -- 2. battery percentage
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
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
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = colors[cell_no] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
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
    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    local title = wezterm.truncate_right(tab.active_pane.title, max_width)
    local tab_index = tab.tab_index
    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = tab_index .. ': ' .. title .. ' ' },
    }
  end
)

return {
    window_frame = {
        font = wezterm.font { family = 'Inconsolata', weight = 'Bold' },
        font_size = 20.0,
    },
    font = wezterm.font_with_fallback {
        'Inconsolata',
        'JetBrains Mono',
    },
    font_size = 24.0,
    color_scheme = "tokyonight",
    audible_bell = "Disabled",
    use_fancy_tab_bar = true,
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
        {
            key = 't',
            mods = 'CTRL',
            action = wezterm.action.SpawnTab 'DefaultDomain'
        },
        { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollByLine(-1) },
        { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },
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
