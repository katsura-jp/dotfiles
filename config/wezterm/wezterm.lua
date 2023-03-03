local wezterm = require 'wezterm'
local act = wezterm.action


wezterm.on('update-right-status', function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {}

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find '/'
    local cwd = ''
    local hostname = ''
    if slash then
      hostname = cwd_uri:sub(1, slash - 1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find '[.]'
      if dot then
        hostname = hostname:sub(1, dot - 1)
      end
      -- and extract the cwd from the uri
      cwd = cwd_uri:sub(slash)

      table.insert(cells, cwd)
      table.insert(cells, hostname)
    end
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M'
  table.insert(cells, date)

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3)
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    '#3c1361',
    '#52307c',
    '#663a82',
    '#7c5295',
    '#b491c8',
  }

  -- Foreground color for the text across the fade
  local text_fg = '#c0c0c0'

  -- The elements to be formatted
  local elements = {}
  -- How many cells have been formatted
  local num_cells = 0

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, { Foreground = { Color = text_fg } })
    table.insert(elements, { Background = { Color = colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not is_last then
      table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
      table.insert(elements, { Text = SOLID_LEFT_ARROW })
    end
    num_cells = num_cells + 1
  end

  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements))
end)


return {
    font = wezterm.font_with_fallback {
        'Inconsolata',
        'JetBrains Mono',
    },
    font_size = 24.0,
    color_scheme = "tokyonight",
    audible_bell = "Disabled",

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
