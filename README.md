# murkavpn-geo

GeoIP и Geosite для маршрутизации Murka VPN (Happ / Xray).

- `geoip.dat`, `geosite.dat` — каждые 6 часов скачиваются из открытой сборки [runetfreedom/russia-v2ray-rules-dat](https://github.com/runetfreedom/russia-v2ray-rules-dat) и обрезаются до категорий из профиля (`scripts/trim.js`).
- `profiles/murka-smart-ru.json` — готовый профиль маршрутизации (Happ / Incy), шаблон в `murka-smart-ru.template.json`.
- `make-header.ps1 -User Tailung-r` — собирает строку `happ://routing/onadd/...` для заголовка `routing`.
