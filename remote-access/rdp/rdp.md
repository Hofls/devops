### Info
* `rdp` - desktop sharing system
* Windows client - default `Remote Desktop Connection`
* Look at `images-list.md` in `/containers/docker` folder

### Install RDP on Ubuntu server
* Install GUI: `apt update && apt install --no-install-recommends ubuntu-desktop`
* Install RDP: `apt install xrdp`
* Add xrdp user to cert group: `adduser xrdp ssl-cert`
* Done! Use RDP client to connect to server

### Install RDP on CentOS 7 server
* Install GUI (pick one):
    * GNOME:
        * `yum check-update && yum -y groups install "GNOME Desktop"`
        * `systemctl set-default graphical`
    * XFCE:
        * `yum check-update && yum install -y epel-release`
        * `yum groupinstall -y "Xfce"`
        * `echo "xfce4-session" > /home/hofls2/.Xclients`
        * `chmod a+x /home/hofls2/.Xclients`
* Install RDP:
    * `yum install -y epel-release`
    * `yum install -y xrdp`
    * `systemctl start xrdp`
* Turn off VPN:
    * `systemctl stop firewalld`
