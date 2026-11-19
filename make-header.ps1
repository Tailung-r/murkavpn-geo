# Использование:
#   .\make-header.ps1 -User Tailung-r   -> geo-файлы из твоего репозитория murkavpn-geo
#   .\make-header.ps1                   -> geo-файлы прямо с runetfreedom
# Создаёт:
#   profiles\murka-smart-ru.json  - готовый профиль (ссылка для Incy autorouting)
#   routing-header.txt            - строка для заголовка routing (Happ)
param([string]$User = "")
if ($User) { $base = "https://raw.githubusercontent.com/$User/murkavpn-geo/main/lite" }
else       { $base = "https://raw.githubusercontent.com/runetfreedom/russia-v2ray-rules-dat/release" }
$ts   = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
$json = (Get-Content "$PSScriptRoot\profiles\murka-smart-ru.template.json" -Raw -Encoding UTF8).Replace("__TS__", "$ts").Replace("__BASE__", $base)
[IO.File]::WriteAllText("$PSScriptRoot\profiles\murka-smart-ru.json", $json, (New-Object Text.UTF8Encoding $false))
$min  = ($json | ConvertFrom-Json | ConvertTo-Json -Compress -Depth 5)
$b64  = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($min))
$out  = "happ://routing/onadd/$b64"
Set-Content -Path "$PSScriptRoot\routing-header.txt" -Value $out -Encoding ascii -NoNewline
$out
