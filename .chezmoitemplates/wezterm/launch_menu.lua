{{/* ==================== Launch menu ==================== */}}

config.launch_menu = {}

{{ $data := index . "wezterm" }}
{{ $os := .chezmoi.os }}

{{ with $data }}
  {{ with index . "launch_menu" }}
    {{ range . }}
      {{ $label := .label }}
      {{ $args := .args }}
      {{ $cwd := "" }}
      {{ if index . "cwd" }}{{ $cwd = index . "cwd" }}{{ end }}
      table.insert(config.launch_menu, {
        label = '{{ $label }}',
        args = { {{ range $a := $args }}'{{ $a }}', {{ end }} },
        {{- if ne $cwd "" }} cwd = '{{ $cwd }}', {{ end }}
      })
    {{ end }}
  {{ else }}
    {{/* Default menu based on OS */}}
    {{ if eq $os "windows" }}
      table.insert(config.launch_menu, { label = 'PowerShell 7', args = { 'pwsh.exe', '-NoLogo' } })
      table.insert(config.launch_menu, { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } })
      table.insert(config.launch_menu, { label = 'Command Prompt', args = { 'cmd.exe' } })
    {{ else }}
      table.insert(config.launch_menu, { label = 'Zsh', args = { 'zsh', '-l' } })
      table.insert(config.launch_menu, { label = 'Bash', args = { 'bash', '-l' } })
    {{ end }}
  {{ end }}
{{ else }}
  {{/* No .wezterm data, use OS defaults */}}
  {{ if eq $os "windows" }}
    table.insert(config.launch_menu, { label = 'PowerShell 7', args = { 'pwsh.exe', '-NoLogo' } })
    table.insert(config.launch_menu, { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } })
    table.insert(config.launch_menu, { label = 'Command Prompt', args = { 'cmd.exe' } })
  {{ else }}
    table.insert(config.launch_menu, { label = 'Zsh', args = { 'zsh', '-l' } })
    table.insert(config.launch_menu, { label = 'Bash', args = { 'bash', '-l' } })
  {{ end }}
{{ end }}
