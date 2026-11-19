# murkavpn-geo

GeoIP и Geosite для маршрутизации Murka VPN (Happ / Incy).

- `geo/geoip.dat`, `geo/geosite.dat` — geo-файлы, обновляются каждые 6 часов.
- `profiles/murka-smart-ru.json` — готовый профиль маршрутизации (ссылка для Incy autorouting), шаблон в `murka-smart-ru.template.json`.
- `make-header.ps1 -User Tailung-r` — собирает профиль и строку `happ://routing/onadd/...` для заголовка `routing`.
