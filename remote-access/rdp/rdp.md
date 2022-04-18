### Info
* `rdp` - desktop sharing system
* Windows client - default `Remote Desktop Connection`
* Look at `images-list.md` in `/containers/docker` folder

### Install RDP on Ubuntu server
* Install GUI: `apt install --no-install-recommends ubuntu-desktop`
* Install RDP: `apt install xrdp`
* Add xrdp user to cert group: `adduser xrdp ssl-cert`
* Done! Use RDP client to connect to server
