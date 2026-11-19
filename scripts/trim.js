// Оставляет в geoip.dat / geosite.dat только категории, которые использует профиль.
// node scripts/trim.js <profile.json> <geoip.dat> <geosite.dat>
const fs = require('fs');
const [profilePath, geoipPath, geositePath] = process.argv.slice(2);
const p = JSON.parse(fs.readFileSync(profilePath, 'utf8'));
const lists = ['DirectSites', 'DirectIp', 'ProxySites', 'ProxyIp', 'BlockSites', 'BlockIp'].flatMap(k => p[k] || []);
const want = { geoip: new Set(), geosite: new Set() };
for (const r of lists) { const m = /^(geoip|geosite):(.+)$/.exec(r); if (m) want[m[1]].add(m[2].toLowerCase()); }

function varint(b, i) { let r = 0, s = 0, x; do { x = b[i++]; r += (x & 0x7f) * 2 ** s; s += 7; } while (x >= 0x80); return [r, i]; }
function trim(path, keep) {
  const b = fs.readFileSync(path), parts = [], found = new Set();
  let i = 0;
  while (i < b.length) {
    const start = i; let l; [, i] = varint(b, i); [l, i] = varint(b, i);
    const end = i + l, m = b.subarray(i, end);
    let j = 0, ll; [, j] = varint(m, j); [ll, j] = varint(m, j);
    const code = m.subarray(j, j + ll).toString().toLowerCase();
    if (keep.has(code)) { parts.push(b.subarray(start, end)); found.add(code); }
    i = end;
  }
  const missing = [...keep].filter(c => !found.has(c));
  if (missing.length) { console.error(`${path}: нет категорий ${missing.join(', ')}`); process.exit(1); }
  const out = Buffer.concat(parts); fs.writeFileSync(path, out);
  console.log(`${path}: ${found.size} категорий, ${(b.length / 1e6).toFixed(1)} МБ -> ${(out.length / 1e6).toFixed(2)} МБ`);
}
trim(geoipPath, want.geoip);
trim(geositePath, want.geosite);
