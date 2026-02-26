{{/* ==================== Color scheme ==================== */}}

{{ $data := index . "wezterm" }}

{{ $dark := "Noctis Minimus" }}
{{ with $data }}{{ with index . "color_scheme_dark" }}{{ $dark = . }}{{ end }}{{ end }}

{{ $light := "Noctis Lux" }}
{{ with $data }}{{ with index . "color_scheme_light" }}{{ $light = . }}{{ end }}{{ end }}

local function scheme_for_appearance(appearance)
  if appearance:find('Dark') then
    return '{{ $dark }}'
  else
    return '{{ $light }}'
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
