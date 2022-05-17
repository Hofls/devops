### Routes (Windows)
* Use case - after turning on VPN routes get messed up (everything goes through new gateway)
* Routes list - `route print`, go to section `IPv4 (Active routes)`
* Add new route - `route ADD 10.240.12.0 MASK 255.255.255.0 10.141.23.14`
    * 0 in mask means any number (`*`)
* Delete route - `route DELETE 10.240.12.0 MASK 255.255.255.0 10.141.23.14`
