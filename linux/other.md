## File system hierarchy
* `etc` - configurations
* `opt` - optional, 3rd party software
* `tmp` - temporary files
* `usr` - user data
    * `/usr/bin` - executables
* `var` - variable data
    * `/var/log` - logs

## Package manager problems
##### Package manager installs old version of package
* Example: after `zypper refresh`, zypper still installs ancient version of openvpn
* `OpenSUSE 42.3` fixes (pick 1):
    * Via repository:
        * Find [repository]([Download .rpm package](https://software.opensuse.org/download/package?package=openvpn&project=network%3Avpn))
        * ```
          zypper addrepo https://download.opensuse.org/repositories/network:vpn/openSUSE_Leap_42.3/network:vpn.repo
          zypper refresh
          zypper install openvpn
          ```
    * Manually:
        * [Download .rpm package](https://software.opensuse.org/download/package?package=openvpn&project=network%3Avpn)
        * Install - `zypper install openvpn-2.4.8-173.1.x86_64.rpm`

##### Package manager cannot verify signature of a package
* Example: `zypper -n install nginx-1.20.1-1.sles15.ngx.x86_64.rpm` fails with error `Signature verification failed`
* `OpenSUSE 15.3` fix:
    ```
    zypper refresh
    zypper -n install curl ca-certificates gpg2
    curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
    rpmkeys --import /tmp/nginx_signing.key
    ```
  * Then try to install nginx again
