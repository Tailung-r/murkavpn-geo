# Использование:
#   .\make-header.ps1 -User ТВОЙ_ЛОГИН      -> ссылки на твой репозиторий murkavpn-geo
#   .\make-header.ps1                       -> ссылки прямо на runetfreedom (работает сразу)
param([string]$User = "")
if ($User) { $base = "https://raw.githubusercontent.com/$User/murkavpn-geo/main" }
else       { $base = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release" }
$ts   = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$json = (Get-Content "$PSScriptRoot\profiles\murka-smart-ru.json" -Raw -Encoding UTF8).Replace("__TS__", "$ts").Replace("__BASE__", $base)
$min  = ($json | ConvertFrom-Json | ConvertTo-Json -Compress -Depth 5)
$b64  = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($min))
$out  = "happ://routing/onadd/$b64"
Set-Content -Path "$PSScriptRoot\routing-header.txt" -Value $out -Encoding ascii -NoNewline
$out
