#!/usr/bin/expect
spawn /opt/forticlientsslvpn/64bit/forticlientsslvpn_cli --server vpn-ps.som.com:10443 --vpnuser symiga --pkcs12 symiga.pfx --keepalive
expect "Password for VPN:"
send "qwerty\r"
expect "Password for PKCS#12:"
send "qwerty123\r"
expect "*(Y/N)"
send "Y\r"
interact