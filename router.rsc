# 2026-08-11 12:03:18 by RouterOS 7.24beta3
# software id = XXXXXXXXXX
#
# model = RB951Ui-2nD
# serial number = XXXXXXXXXXXXX
/interface bridge
add arp=reply-only name=Bridge-LAN port-cost-mode=short
/interface ethernet
set [ find default-name=ether1 ] name=WAN
/interface lte
set [ find default-name=lte1 ] allow-roaming=yes
/interface vlan
add interface=ether3 name=vlan10 vlan-id=10
add interface=ether3 name=vlan20 vlan-id=20
add interface=ether3 name=vlan30 vlan-id=30
/disk
add parent=usb1 partition-number=1 partition-offset=1048576 partition-size=\
    31422656512 type=partition
add parent=usb1 partition-number=2 partition-offset=31423705088 \
    partition-size=33554432 type=partition
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=password \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n disabled=no frequency=auto \
    mode=ap-bridge security-profile=password ssid=shikikan-homelab
add disabled=no keepalive-frames=disabled mac-address=D6:01:C3:67:5E:9E \
    master-interface=wlan1 multicast-buffering=disabled name=wlan2 ssid=\
    hotspot-lab wds-default-cost=1 wps-mode=disabled
/ip hotspot profile
set [ find default=yes ] login-by=http-chap
add dns-name=hotspot.lab hotspot-address=192.169.90.1 html-directory=\
    flash/hotspot login-by=http-chap name=hsprof1
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=no shared-users=4
add add-mac-cookie=no !mac-cookie-timeout name=guest rate-limit=5M/5M \
    shared-users=10
add name=shikikan rate-limit=5M/5M shared-users=4
add name=admin-test
/ip pool
add name=dhcp_pool0 ranges=192.168.88.2-192.168.88.254
add name=dhcp_pool1 ranges=192.168.100.2-192.168.100.254
add name=dhcp_pool2 ranges=192.168.200.2-192.168.200.254
add name=dhcp_pool3 ranges=192.168.88.2-192.168.88.254
add name=dhcp_pool4 ranges=10.10.10.2-10.10.10.254
add name=dhcp_pool5 ranges=10.10.20.2-10.10.20.254
add name=dhcp_pool6 ranges=10.10.30.2-10.10.30.254
add name=hs-pool-14 ranges=192.169.90.2-192.169.90.254
/ip dhcp-server
add address-pool=dhcp_pool3 interface=Bridge-LAN name=dhcp1
add address-pool=dhcp_pool4 interface=vlan10 name=dhcp2
add address-pool=dhcp_pool5 interface=vlan20 name=dhcp3
add address-pool=dhcp_pool6 interface=vlan30 name=dhcp4
# Interface not running
add address-pool=hs-pool-14 interface=wlan2 name=dhcp5
/ip smb users
set [ find default=yes ] disabled=yes
/queue simple
add max-limit=7M/7M name=queue1 target=vlan30
add max-limit=8M/8M name=queue-daffa target=\
    192.168.88.252/32,192.168.88.253/32,192.168.88.254/32
/routing bgp template
set default disabled=no output.network=bgp-networks
/routing ospf instance
add disabled=no name=default-v2
/routing ospf area
add disabled=yes instance=default-v2 name=backbone-v2
/user group
add name=demo policy="local,telnet,ssh,read,winbox,web,rest-api,!ftp,!reboot,!\
    write,!policy,!test,!password,!sniff,!sensitive,!api,!romon"
/interface bridge port
add bridge=Bridge-LAN ingress-filtering=no interface=ether2 \
    internal-path-cost=10 path-cost=10
add bridge=Bridge-LAN ingress-filtering=no interface=wlan1 \
    internal-path-cost=10 path-cost=10
/ip firewall connection tracking
set udp-timeout=10s
/ip settings
set max-neighbor-entries=8192
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192
/interface detect-internet
set detect-interface-list=all
/interface ovpn-server server
add auth=sha1,md5 mac-address=FE:67:80:64:54:9B name=ovpn-server1
/ip address
add address=192.168.88.1/24 interface=Bridge-LAN network=192.168.88.0
add address=10.10.10.1/24 interface=vlan10 network=10.10.10.0
add address=10.10.20.1/24 interface=vlan20 network=10.10.20.0
add address=10.10.30.1/24 interface=vlan30 network=10.10.30.0
add address=192.169.90.1/24 interface=wlan2 network=192.169.90.0
/ip arp
add address=192.168.88.253 interface=Bridge-LAN mac-address=FC:A9:F5:57:23:93
add address=192.168.88.254 interface=Bridge-LAN mac-address=BC:FC:E7:C4:4C:60
add address=192.168.88.252 interface=Bridge-LAN mac-address=04:68:74:A4:C7:FF
/ip dhcp-client
add interface=WAN name=ether1
/ip dhcp-server lease
add address=192.168.88.254 client-id=1:bc:fc:e7:c4:4c:60 mac-address=\
    BC:FC:E7:C4:4C:60 server=dhcp1
add address=192.168.88.253 client-id=1:fc:a9:f5:57:23:93 mac-address=\
    FC:A9:F5:57:23:93 server=dhcp1
add address=192.168.88.252 client-id=1:4:68:74:a4:c7:ff mac-address=\
    04:68:74:A4:C7:FF server=dhcp1
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=10.10.20.0/24 gateway=10.10.20.1
add address=10.10.30.0/24 gateway=10.10.30.1
add address=192.168.88.0/24 gateway=192.168.88.1
add address=192.168.100.0/24 gateway=192.168.100.1
add address=192.168.200.0/24 gateway=192.168.200.1
add address=192.169.90.0/24 comment="hotspot network" gateway=192.169.90.1
/ip dns
set allow-remote-requests=yes use-doh-server=\
    https://dns.cloudflare.com/dns-query
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface=WAN
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=192.169.90.0/24
/ip hotspot
add address-pool=hs-pool-14 disabled=no interface=wlan2 name=hotspot1 \
    profile=hsprof1
/ip hotspot user
add name=shikikan profile=shikikan
add name=guest profile=guest
add name=ardaffa profile=admin-test
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip route
add disabled=no dst-address=10.10.10.1/24 gateway=172.16.0.12 routing-table=\
    main
/routing bfd configuration
add disabled=no interfaces=all min-rx=200ms min-tx=200ms multiplier=5
/system clock
set time-zone-name=Asia/Jakarta
/system identity
set name=shikikan-homelab
/system package update
set channel=development
