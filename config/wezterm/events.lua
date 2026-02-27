local wezterm = require 'wezterm'

-- Show indicator when Ctrl+B key table is active
wezterm.on('update-status', function(window, pane)
  local key_table = window:active_key_table()
  local indicator = ''
  if key_table then
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
