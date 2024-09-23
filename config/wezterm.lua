local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.color_scheme = "Dark+"
config.font_size = 18.0
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_decorations = "RESIZE"

config.font = wezterm.font {
  family = 'JetBrains Mono',
  italic = false,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}

config.leader = {
  key = "g",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

-- maximize on startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- maximize on new tab/window
-- source: https://github.com/wez/wezterm/issues/3173#issuecomment-1722531883
wezterm.on("window-config-reloaded", function(window, pane)
  -- approximately identify this gui window, by using the associated mux id
  local id = tostring(window:window_id())

  -- maintain a mapping of windows that we have previously seen before in this event handler
  local seen = wezterm.GLOBAL.seen_windows or {}
  -- set a flag if we haven't seen this window before
  local is_new_window = not seen[id]
  -- and update the mapping
  seen[id] = true
  wezterm.GLOBAL.seen_windows = seen

  -- now act upon the flag
  if is_new_window then
    window:maximize()
  end
end)

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

config.keys = {
  -- pane navigation
  {
    mods = "LEADER",
    key = "h",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "LEADER",
    key = "l",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    mods = "LEADER",
    key = "k",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "LEADER",
    key = "j",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },

  -- splitting
  {
    mods   = "LEADER",
    key    = "s",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    mods   = "LEADER",
    key    = "v",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- maximise pane
  {
    mods = "LEADER",
    key = "z",
    action = wezterm.action.TogglePaneZoomState,
  },

  -- rotate panes
  {
    mods = "LEADER",
    key = "Space",
    action = wezterm.action.RotatePanes("Clockwise"),
  },

  -- show the pane selection mode
  -- swap the active and selected panes
  {
    mods = "LEADER",
    key = "0",
    action = wezterm.action.PaneSelect { mode = "SwapWithActive" },
  },

  -- activate copy mode or vim mode
  {
    mods = "LEADER",
    key = "Enter",
    action = wezterm.action.ActivateCopyMode,
  },

  -- last tab
  {
    mods = "LEADER|CTRL",
    key = "g",
    action = wezterm.action.ActivateLastTab,
  },

  -- new tab
  {
    mods = "LEADER",
    key = "c",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- rename tab
  -- https://wezfurlong.org/wezterm/config/lua/keyassignment/PromptInputLine.html#example-of-interactively-renaming-the-current-tab
  {
    mods = "LEADER",
    key = ",",
    action = wezterm.action.PromptInputLine {
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  -- next/prev tab
  {
    mods = "LEADER",
    key = "n",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    mods = "LEADER",
    key = "p",
    action = wezterm.action.ActivateTabRelative(-1),
  },

  -- toggle between nvim and terminal
  {
    mods = "CTRL",
    key = ";",
    action = wezterm.action_callback(function(_, pane)
      local tab = pane:tab()
      local panes = tab:panes_with_info()
      local process_name = panes[1].pane:get_foreground_process_name()

      if #panes > 2 or not basename(process_name) == "nvim" then
        return
      end

      tab:set_zoomed(false)

      if #panes == 1 then
        pane:split({ direction = "Bottom", size = 0.4 })
      elseif not panes[1].is_zoomed then
        panes[1].pane:activate()
      elseif panes[1].is_zoomed then
        panes[2].pane:activate()
      end

      tab:set_zoomed(true)
    end),
  },
}

-- LEADER + number to activate that tab
for i = 1, 9 do
  table.insert(config.keys, {
    mods = "LEADER",
    key = tostring(i),
    action = wezterm.action.ActivateTab(i - 1),
  })
end

-- default tab title
wezterm.on(
  "format-tab-title",
  function(tab_info)
    local title = tab_info.tab_title

    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
      return title
    end

    -- use current process as default title
    return basename(tab_info.active_pane.foreground_process_name)
  end
)

return config
