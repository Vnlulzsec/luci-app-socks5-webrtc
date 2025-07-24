#!/bin/sh
# Cài đặt luci-app-socks5 + GOST v3 + auto redirect TCP+UDP + block WebRTC leak

echo "[+] Đang tải gói .ipk..."
curl -L -o /tmp/luci-app-socks5.ipk https://github.com/YOUR_USERNAME/luci-app-socks5/releases/latest/download/luci-app-socks5-webrtc-bypass.ipk

echo "[+] Đang cài đặt gói..."
opkg update
opkg install /tmp/luci-app-socks5.ipk luci iptables ipset ca-bundle ca-certificates ip-full curl

echo "[+] Tải GOST v3 ARM64 (MT3000)..."
/usr/bin/gost --version >/dev/null 2>&1 || (
  curl -L -o /usr/bin/gost.gz https://github.com/go-gost/gost/releases/download/v3.0.0-beta.15/gost-linux-arm64-3.0.0-beta.15.gz
  gzip -d /usr/bin/gost.gz
  chmod +x /usr/bin/gost
)

echo "[+] Khởi động dịch vụ SOCKS5 routing..."
/etc/init.d/socks5apply enable
/etc/init.d/socks5apply restart

echo "[✓] Cài đặt hoàn tất. Truy cập: http://<router-ip>/cgi-bin/luci/admin/network/socks5"
