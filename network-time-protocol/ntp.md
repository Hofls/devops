### NTP
* NTP - networking protocol for time synchronization between computers

### Sync without internet access
* Problem - your network has no internet access, but you still need to synchronize time
* Solution - make one NTP server and bunch of NTP clients
* NTP server:
    * `apt update && apt install ntp`
    * `ntpq -p` should show other NTP servers
    * `nano /etc/ntp.conf` 
        * Comment out lines like `pool 0.ubuntu.pool.ntp.org iburst`
        * Add lines:
        ```
        server 127.127.1.0
        fudge 127.127.1.0 stratum 1
        ```
    * `service ntp restart`
    * `ntpq -p` should show this NTP server
    ```
    remote           refid      st t when poll reach   delay   offset  jitter
    ==============================================================================
    LOCAL(0)        .LOCL.      1 l   12   64    1    0.000   +0.000   0.000
    ```
    * If reach is 0 - check logs
        * `systemctl status ntp`
    * `timedatectl set-time 21:45:53` to change time
    * `date && timedatectl` to check time
* NTP client:
    * `apt update && apt install ntp`
    * `ntpq -p` should show other NTP servers
    * `nano /etc/ntp.conf` 
        * Comment out lines like `pool 0.ubuntu.pool.ntp.org iburst`
        * Add line `server 154.44.125.32` (NTP server IP)
    * `service ntp restart`
    * `ntpq -p` should show your NTP server
    ```
         remote           refid      st t when poll reach   delay   offset  jitter
    ==============================================================================
     154.44.125.32   LOCAL(0)         2 u   35   64    7    0.338   +5.059   2.647
    ```
    * `date && timedatectl` should show same time as NTP server
