local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

-- Collect workspace/tab data from mux
local function collect_workspace_data()
  local mux = wezterm.mux
  local ws_windows = {}
  local ws_order = {}
  for _, mux_win in ipairs(mux.all_windows()) do
    local ws = mux_win:get_workspace()
    if not ws_windows[ws] then
      ws_windows[ws] = {}
      table.insert(ws_order, ws)
    end
    table.insert(ws_windows[ws], mux_win)
  end
  table.sort(ws_order)
  return ws_windows, ws_order
end

-- Hierarchical workspace/tab selector (like tmux prefix + w)
function M.show_workspace_tabs(window, pane)
  local ws_windows, ws_order = collect_workspace_data()
  local choices = {}
  local lookup = {}
  local current_ws = window:active_workspace()

  local idx = 0
  for _, ws in ipairs(ws_order) do
    -- Collect all tabs for this workspace
    local all_tabs = {}
    for _, mux_win in ipairs(ws_windows[ws]) do
      for _, tab_info in ipairs(mux_win:tabs_with_info()) do
        table.insert(all_tabs, tab_info)
      end
    end

    -- Workspace header
    local ws_marker = ws == current_ws and ' (attached)' or ''
    local ws_id = tostring(idx)
    lookup[ws_id] = { type = 'workspace', workspace = ws }
    table.insert(choices, {
      id = ws_id,
      label = '+ ' .. ws .. ': ' .. #all_tabs .. ' tabs' .. ws_marker,
    })
    idx = idx + 1

    -- Tab entries with tree characters
    for i, tab_info in ipairs(all_tabs) do
      local active_pane = tab_info.tab:active_pane()
      local process_name = active_pane:get_foreground_process_name() or ''
      local process = process_name:match('([^/\\]+)$') or active_pane:get_title()
      local is_active = tab_info.is_active and ws == current_ws
      local marker = is_active and ' *' or ''
      local tree = i == #all_tabs and '└─' or '├─'
      local tab_id = tostring(idx)
      lookup[tab_id] = { type = 'tab', workspace = ws, tab_index = tab_info.index }
      table.insert(choices, {
        id = tab_id,
        label = '  ' .. tree .. ' ' .. tostring(tab_info.index) .. ': ' .. process .. marker,
      })
      idx = idx + 1
    end
  end

  window:perform_action(
    act.InputSelector {
      action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
        if not id then return end
        local entry = lookup[id]
        if not entry then return end
        inner_window:perform_action(
          act.SwitchToWorkspace { name = entry.workspace },
          inner_pane
        )
        if entry.type == 'tab' then
          inner_window:perform_action(
            act.ActivateTab(entry.tab_index),
            inner_pane
          )
        end
      end),
      title = 'Tabs & Workspaces',
      choices = choices,
      fuzzy = true,
    },
    pane
  )
end

-- Kill workspace selector using InputSelector
function M.kill_workspace_selector(window, pane)
  local ws_windows, ws_order = collect_workspace_data()
  local current_ws = window:active_workspace()

  if #ws_order <= 1 then return end

  local choices = {}
  local ws_tab_counts = {}
  for _, ws in ipairs(ws_order) do
    local tab_count = 0
    for _, mux_win in ipairs(ws_windows[ws]) do
      for _ in ipairs(mux_win:tabs_with_info()) do
        tab_count = tab_count + 1
      end
    end
    ws_tab_counts[ws] = tab_count
    local marker = ws == current_ws and ' (attached)' or ''
    table.insert(choices, {
      id = ws,
      label = ws .. ' (' .. tab_count .. ' windows)' .. marker,
    })
  end

  window:perform_action(
    act.InputSelector {
      action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
        if not id then return end
        local tab_count = ws_tab_counts[id] or 0
        if tab_count == 0 then return end

        -- Switch to the target workspace first
        inner_window:perform_action(act.SwitchToWorkspace { name = id }, inner_pane)

        -- After switch completes, close tabs using the new workspace's pane
        wezterm.time.call_after(0.5, function()
          local ok, err = pcall(function()
            if inner_window:active_workspace() ~= id then return end
            local target_pane = inner_window:active_pane()
            if not target_pane then return end
            local actions = {}
            for _ = 1, tab_count do
              table.insert(actions, act.CloseCurrentTab { confirm = false })
            end
            inner_window:perform_action(act.Multiple(actions), target_pane)
          end)
          if not ok then
            wezterm.log_error('kill workspace: ' .. tostring(err))
          end
        end)
      end),
      title = 'Kill Workspace',
      choices = choices,
      fuzzy = true,
    },
    pane
  )
end

return M
