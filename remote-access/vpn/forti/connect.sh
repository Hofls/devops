#!/usr/bin/expect
spawn /opt/forticlientsslvpn/64bit/forticlientsslvpn_cli --server vpn-ps.som.com:10443 --vpnuser symiga --pkcs12 symiga.pfx --keepalive
expect "Password for VPN:"
send -- q-w#er[ty\r
expect "Password for PKCS#12:"
send -- q-w#er[ty123\r
expect "*(Y/N)"
send "Y\r"
interact