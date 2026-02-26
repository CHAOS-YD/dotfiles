{{/* ==================== Font configuration ==================== */}}

{{ $data := index . "wezterm" }}

{{ $defaultFonts := list
  (dict "family" "Maple Mono NF CN" "features" (dict "calt" 1 "liga" 1))
  (dict "family" "Fira Code" "features" (dict "calt" 1 "liga" 1))
  (dict "family" "JetBrains Mono" "weight" "Medium" "features" (dict "calt" 1 "liga" 1))
  "Monospace"
}}

{{ $fonts := $defaultFonts }}
{{ with $data }}{{ with index . "fonts" }}{{ $fonts = . }}{{ end }}{{ end }}

{{ $size := 13.0 }}
{{ with $data }}{{ with index . "font_size" }}{{ $size = . }}{{ end }}{{ end }}

config.font = wezterm.font_with_fallback({
  {{- range $f := $fonts }}
    {{- if kindIs "map" $f }}
      {
        family = '{{ $f.family }}',
        {{- if index $f "weight" }} weight = '{{ index $f "weight" }}', {{ end }}
        {{- if index $f "style" }} style = '{{ index $f "style" }}', {{ end }}
        {{- if index $f "stretch" }} stretch = '{{ index $f "stretch" }}', {{ end }}
        {{- if index $f "features" }}
        harfbuzz_features = {
          {{- range $k, $v := index $f "features" }}
          '{{ $k }}={{ $v }}',
          {{- end }}
        },
        {{- end }}
      },
    {{- else }}
      '{{ $f }}',
    {{- end }}
  {{- end }}
})

config.font_size = {{ $size }}
config.line_height = 1.2
