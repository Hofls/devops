## File system hierarchy
* `etc` - configurations
* `opt` - optional, 3rd party software
* `tmp` - temporary files
* `var` - variable data
    * `/var/log` - logs

## Package manager problems
##### Package manager installs old version of package
* `Ubuntu` (pick 1):
    * TODO
* `OpenSUSE 42.3` (pick 1):
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
