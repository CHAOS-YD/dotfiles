{{/* ==================== General appearance ==================== */}}

{{ $data := index . "wezterm" }}

{{ $opacity := 0.95 }}
{{ with $data }}{{ with index . "opacity" }}{{ $opacity = . }}{{ end }}{{ end }}

{{ $cols := 120 }}
{{ with $data }}{{ with index . "initial_cols" }}{{ $cols = . }}{{ end }}{{ end }}

{{ $rows := 28 }}
{{ with $data }}{{ with index . "initial_rows" }}{{ $rows = . }}{{ end }}{{ end }}

-- Window transparency
config.window_background_opacity = {{ $opacity }}
config.text_background_opacity = 0.9

-- Padding
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

-- Tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

-- Cursor
config.default_cursor_style = 'BlinkingBar'

-- Performance
config.front_end = 'WebGpu'
config.max_fps = 60
config.animation_fps = 60
config.automatically_reload_config = true

-- Window size
config.initial_cols = {{ $cols }}
config.initial_rows = {{ $rows }}
