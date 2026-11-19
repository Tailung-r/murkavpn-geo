# murkavpn-geo

GeoIP и Geosite для маршрутизации Murka VPN (Happ / Xray).

- `geoip.dat`, `geosite.dat` — обновляются каждые 6 часов из открытой сборки [runetfreedom/russia-v2ray-rules-dat](https://github.com/runetfreedom/russia-v2ray-rules-dat).
- `profiles/murka-smart-ru.json` — готовый профиль маршрутизации (Happ / Incy), шаблон в `murka-smart-ru.template.json`.
- `make-header.ps1 -User Tailung-r` — собирает строку `happ://routing/onadd/...` для заголовка `routing`.
