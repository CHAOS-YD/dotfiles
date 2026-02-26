{{/* ==================== Keybindings ==================== */}}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

{{ $data := index . "wezterm" }}

{{ $copyKey := "c" }}
{{ $copyMods := "CTRL|SHIFT" }}
{{ $pasteKey := "v" }}
{{ $pasteMods := "CTRL|SHIFT" }}

{{ with $data }}
  {{ with index . "key_copy" }}{{ $copyKey = . }}{{ end }}
  {{ with index . "key_copy_mods" }}{{ $copyMods = . }}{{ end }}
  {{ with index . "key_paste" }}{{ $pasteKey = . }}{{ end }}
  {{ with index . "key_paste_mods" }}{{ $pasteMods = . }}{{ end }}
{{ end }}

{{/* Guard against empty strings */}}
{{ if eq $copyKey "" }}{{ $copyKey = "c" }}{{ end }}
{{ if eq $copyMods "" }}{{ $copyMods = "CTRL|SHIFT" }}{{ end }}
{{ if eq $pasteKey "" }}{{ $pasteKey = "v" }}{{ end }}
{{ if eq $pasteMods "" }}{{ $pasteMods = "CTRL|SHIFT" }}{{ end }}

config.keys = {
  -- Pane splitting
  { key = 'v', mods = 'LEADER', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Pane navigation
  { key = 'LeftArrow',  mods = 'LEADER', action = action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'LEADER', action = action.ActivatePaneDirection 'Right' },
  { key = 'DownArrow',  mods = 'LEADER', action = action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow',    mods = 'LEADER', action = action.ActivatePaneDirection 'Up' },

  -- Close pane/tab
  { key = 'q', mods = 'LEADER', action = action.CloseCurrentPane { confirm = false } },
  { key = 'w', mods = 'LEADER', action = action.CloseCurrentTab { confirm = false } },

  -- Tab management
  { key = 't', mods = 'LEADER', action = action.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'CTRL|SHIFT', action = action.SpawnTab 'DefaultDomain' },

  -- Copy/Paste
  { key = '{{ $copyKey }}', mods = {{ $copyMods | quote }}, action = action.CopyTo 'Clipboard' },
  { key = '{{ $pasteKey }}', mods = {{ $pasteMods | quote }}, action = action.PasteFrom 'Clipboard' },

  -- Search
  { key = 'f', mods = 'CTRL|SHIFT', action = action.Search { CaseInSensitiveString = '' } },

  -- Clear scrollback
  { key = 'k', mods = 'CTRL', action = action.ClearScrollback 'ScrollbackAndViewport' },

  -- Home/End
  { key = 'LeftArrow',  mods = 'ALT', action = action.SendKey { key = 'Home' } },
  { key = 'RightArrow', mods = 'ALT', action = action.SendKey { key = 'End' } },

  -- Command palette
  { key = 'p', mods = 'CTRL|SHIFT', action = action.ActivateCommandPalette },

  -- Reload config
  { key = 'r', mods = 'CTRL|SHIFT', action = action.ReloadConfiguration },

  -- Launch menu
  { key = 's', mods = 'CTRL|SHIFT', action = action.ShowLauncher },
}
