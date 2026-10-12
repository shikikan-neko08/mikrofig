# 2026-10-12 11:24:00 by RouterOS 7.23.5
# software id = XXXX-XXXX
#
# model = RB941-2nD
# serial number = XXXXXXXXXXX
/interface bridge
add name=Bridge-LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name=wifi-password supplicant-identity=""
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=\
    wifi-ap-password supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-onlyn disabled=no frequency=2437 \
    name=Wifi-wan security-profile=wifi-password ssid=IDN
add disabled=no mac-address=DE:2C:6E:E2:5B:60 master-interface=Wifi-wan name=\
    Wifi-ap security-profile=wifi-ap-password ssid="shikikan wifi" wps-mode=\
    disabled
/ip pool
add name=dhcp_pool0 ranges=192.168.88.2-192.168.88.254
add name=dhcp_pool1 ranges=192.168.88.2-192.168.88.254
/ip dhcp-server
add address-pool=dhcp_pool1 interface=Bridge-LAN name=dhcp1
/interface bridge port
add bridge=Bridge-LAN interface=ether3
add bridge=Bridge-LAN interface=ether4
add bridge=Bridge-LAN interface=Wifi-ap
add bridge=Bridge-LAN interface=ether2
/ip address
add address=192.168.88.1/24 interface=Bridge-LAN network=192.168.88.0
/ip dhcp-client
add interface=Wifi-wan name=client1
/ip dhcp-server network
add address=192.168.88.0/24 gateway=192.168.88.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface=Wifi-wan
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=shikikan-router
