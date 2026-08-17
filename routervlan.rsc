# jan/18/2002 05:09:06 by RouterOS 6.45.5
# software id = Q1N2-9J3J
#
# model = 750
# serial number = 25B901848DF1
/interface bridge
add name=bridge1
/interface ethernet switch port
set 0 vlan-header=add-if-missing vlan-mode=secure
set 1 default-vlan-id=10 vlan-header=always-strip vlan-mode=secure
set 2 default-vlan-id=20 vlan-header=always-strip vlan-mode=secure
set 3 default-vlan-id=30 vlan-header=always-strip vlan-mode=secure
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/tool user-manager customer
set admin access=\
    own-routers,own-users,own-profiles,own-limits,config-payment-gw
/tool user-manager profile
add name=Family name-for-users="" override-shared-users=off owner=admin \
    price=0 starts-at=logon validity=0s
add name=Guest name-for-users="" override-shared-users=off owner=admin price=\
    0 starts-at=logon validity=0s
/tool user-manager profile limitation
add address-list="" download-limit=0B group-name="" ip-pool="" ip-pool6="" \
    name=Guest owner=admin rate-limit-min-rx=524288B rate-limit-min-tx=\
    393216B rate-limit-rx=524288B rate-limit-tx=393216B transfer-limit=0B \
    upload-limit=0B uptime-limit=0s
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether5
/interface ethernet switch vlan
add ports=ether2,ether3 switch=switch1 vlan-id=10
add ports=ether2,ether4 switch=switch1 vlan-id=20
add ports=ether2,ether5 switch=switch1 vlan-id=30
/system lcd
set contrast=0 enabled=no port=parallel type=24x4
/system lcd page
set time disabled=yes display-time=5s
set resources disabled=yes display-time=5s
set uptime disabled=yes display-time=5s
set packets disabled=yes display-time=5s
set bits disabled=yes display-time=5s
set version disabled=yes display-time=5s
set identity disabled=yes display-time=5s
set bridge1 disabled=yes display-time=5s
set ether1 disabled=yes display-time=5s
set ether2 disabled=yes display-time=5s
set ether3 disabled=yes display-time=5s
set ether4 disabled=yes display-time=5s
set ether5 disabled=yes display-time=5s
/tool user-manager database
set db-path=user-manager
/tool user-manager profile profile-limitation
add from-time=0s limitation=Guest profile=Guest till-time=23h59m59s weekdays=\
    sunday,monday,tuesday,wednesday,thursday,friday,saturday
/tool user-manager router
add coa-port=1700 customer=admin disabled=no ip-address=127.0.0.1 log=\
    auth-fail name=RB750 shared-secret=1234 use-coa=no
/tool user-manager user
add customer=admin disabled=no ipv6-dns=:: password=Pisang00 shared-users=\
    unlimited username=Ardaffa wireless-enc-algo=none wireless-enc-key="" \
    wireless-psk=""
add customer=admin disabled=no ipv6-dns=:: password="" shared-users=unlimited \
    username=Andi wireless-enc-algo=none wireless-enc-key="" wireless-psk=""
add customer=admin disabled=no ipv6-dns=:: password="" shared-users=unlimited \
    username=Inung wireless-enc-algo=none wireless-enc-key="" wireless-psk=""
add customer=admin disabled=no ipv6-dns=:: password=guest shared-users=\
    unlimited username=guest wireless-enc-algo=none wireless-enc-key="" \
    wireless-psk=""
add customer=admin disabled=no ipv6-dns=:: password="" shared-users=1 \
    username=Salma wireless-enc-algo=none wireless-enc-key="" wireless-psk=""
