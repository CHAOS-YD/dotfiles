{{/* ==================== Platform-specific settings ==================== */}}

{{ $data := index . "wezterm" }}
{{ $os := .chezmoi.os }}

{{ $defaultProg := list }}
{{ $decorations := "" }}

{{ if eq $os "windows" }}
  {{ $defaultProg = list "pwsh.exe" "-NoLogo" }}
  {{ $decorations = "TITLE|RESIZE" }}
{{ else }}
  {{ $defaultProg = list "bash" "-l" }}
  {{ $decorations = "RESIZE" }}
{{ end }}

{{ with $data }}
  {{ if eq $os "windows" }}
    {{ with index . "default_shell_windows" }}{{ $defaultProg = . }}{{ end }}
  {{ else }}
    {{ with index . "default_shell_linux" }}{{ $defaultProg = . }}{{ end }}
  {{ end }}
{{ end }}

config.window_decorations = '{{ $decorations }}'
config.default_prog = { {{ range $arg := $defaultProg }}'{{ $arg }}', {{ end }} }

{{ if ne $os "windows" }}
  config.enable_wayland = true
{{ end }}
