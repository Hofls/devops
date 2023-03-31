## Info
* `rdp` - desktop sharing system
* Windows client - default `Remote Desktop Connection`
* Other mentions: 
    * [ssh-tunneling](../ssh/ssh-tunneling.md)
    * `images-list.md` in `/containers/docker` folder

## Servers 
#### Install RDP server on Ubuntu
* Install GUI (pick one): 
    * GNOME (heavy):
        * `apt update && apt install --no-install-recommends ubuntu-desktop`
    * XFCE (light):
        * `apt update && apt install xfce4-session`
        * Install a browser (look at desktop.md)
* Install RDP: `apt install -y xrdp`
    * Check that RDP is running - `netstat -tupln` (xrdp should listen on ports 3389, 3350)
* Add xrdp user to cert group: `adduser xrdp ssl-cert`
* Set password for main user - `passwd hofls`
* Done! Use RDP client to connect to server

#### Install RDP server on CentOS 7
* Install GUI (pick one):
    * GNOME (heavy):
        * `yum check-update`
        * `yum -y groups install "GNOME Desktop"`
        * `systemctl set-default graphical`
    * XFCE (light):
        * `yum check-update`
        * `yum install -y epel-release`
        * `yum groupinstall -y "Xfce"`
        * `echo "xfce4-session" > /home/hofls2/.Xclients`
        * `chmod a+x /home/hofls2/.Xclients`
* Install RDP:
    * `yum install -y epel-release`
    * `yum install -y xrdp`
    * `systemctl start xrdp`
* Set password for main user - `passwd hofls`
* Turn off VPN:
    * `systemctl stop firewalld`

## Clients
#### Install RDP client on Ubuntu
* Install RDP client: 
    * `apt update && apt install remmina -y`
* Connect to RDP server:
    * `Activities` -> `Show Applications` -> `Remmina` -> `New connection profile`
    * Fill `Server`, `Username`, `Password`
    * Press `Save and connect`

#### Install RDP client on CentOS 7 
* Install RDP client: 
    * `yum check-update`
    * `yum install remmina`
* Connect to RDP server:
    * `Applications` -> `Internet` -> `Remmina`
    * Fill `Server`, `Username`, `Password`
    * Press `Save and connect`