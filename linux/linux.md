# Linux


## Commands

#### CLI Usage
* Show recent commands
    * `history`
* Clear CLI
    * `clear`
* Current user and group
    * `id`
* Became almighty root user
    * `sudo su`
* Copy from console
    * Select text with mouse
* Show full path to current working directory
    * `pwd`
* Show documentation for `ls` command:
    * Detailed description, without examples: `man ls`
    * Brief description, with examples: `tldr ls`
* Quickly find out what `-t` parameter means in `ssh-keygen` command:
    * `man ssh-keygen | grep -- -t`
    * `Double dash --` signifies the end of command options, after which only positional parameters accepted
* Autocomplete:
    * `echo "hey" > example.text`
    * `cat ex`
    * Press `Tab`
* Erase command line
    * `ctrl-u`
* Delete a word to the left/right
    * `ctrl+w` / `alt+d`
* Skip one word
    * Backward - `alt+b`
    * Forward - `alt+f`
* Create alias for frequently used command:
    * `alias aws='aws --endpoint-url=http://localhost:4566'`
    
#### Commands combo
* Execute commands in parallel:
    * `echo "a" & echo "b"`
* Execute commands sequentially:
    * `echo "a" && echo "b"`
* Pipeline output of one command to input of another:
    * `echo "good" | grep go`
* Write output of command to file:
    * `echo "a" > example.txt`
* Save output of command to a variable:
    * `commit_message=$(git log --skip 1 -n 1 --format=%B)`
    * `echo $commit_message`
     
#### Processes
* Run command 'standalone.sh' in the background, immune to hangups
    * `nohup /opt/wildfly-15.0.1.Final/bin/standalone.sh &`
* Find and kill process with name containing "prctodth"
     ```
     ps aux | grep prctodth
     kill -9 832747
     ```
* Call `java` from CLI by its name alone, without full path:
    * 1st way (permanent)
        * Create symlink in `/usr/bin`
        * Call `java -version`
    * 2nd way (temporary, only for the session)
        * `export JAVA_HOME=/opt/jdk-15.0.1`
        * `export PATH=$JAVA_HOME/bin:$PATH`
    * 3d way (permanent)
        * `nano /etc/environment`
        * `JAVA_HOME=/opt/jdk-15.0.1`
        * Add to the end of PATH - `:/opt/jdk-15.0.1/bin`
        * Restart server - `reboot`
* Service manager (systemd)
    * For more info look at [other.md](other.md)
    * List all services `systemctl list-units --type=service`
    * Restart service apache2 `systemctl restart apache2`
    * Show apache2 status `systemctl status apache2`
    * Start service automatically on server boot `systemctl enable apache2`
    * Look at service logs `journalctl -u apache2.service`
* Monitor system calls and signals
    * `strace ls`

#### Files/Folders
* Find lines with text "hello world" in main.log
    * `grep -F 'hello world' main.log`
* Find file with name containing 'specopsfls' in this folder and all subfolders
    * `find . -name *specopsfls*` 
* Find folder with name containing 'fldtofnd' in this folder and all subfolders 
    * `find / -type d -name '*fldtofnd*'` 
* Write last 20k lines from services.log to temp.log
    * `tail -n 20000 services.log > temp.log`
* Give all permissions to script `reload.sh`
    * `chmod 777 reload.sh`
* Add a folder to uncompressed archive (.tar):
    * `tar -cvf uncompressed.tar myfolder`
* Extract everything from .tar archive:
    * `tar -xvf uncompressed.tar`
* Ordered list of files/folders in current directory
    * `ls -l`
* Create symlink
    * `ln -s /usr/lib/jvm/jre7/bin/java /usr/bin/java`
* If you are unable to delete some files/folders:
    * Kill process:
        * Find process that holds open files in folder "/var/lib/docker":
            * `lsof | grep /var/lib/docker`
        * Kill it
    * Resolve mounting issues:
     * Try to delete folder: `rm -r docker`
         * Errors will show full path to problematic files/folders
     * Umount each of them: `umount docker/containers/82JDSAJDK2/shm`
* `.` means current folder, e.g.:
    * `docker build .`
    * `helm install kafka-connect .`

#### Resources (RAM/CPU/Disk)
* Display amount of available disk space
    * `df -h`
* Show folders size on current level
    * `du --summarize --human-readable *` or `du -s -h *`
* Live feed of process resource usage
    * `top`
        * Press `e` to switch format of value (kb -> mb -> gb))
        * `shift+m` to sort by RAM usage
        * `shift+p` to sort by CPU usage
* Show total memory usage (RAM/swap)
    * `free -h`
        * Column `free` - amount of memory that is not used at all
        * Column `available` - free memory + memory that is used for cache/buffer (can become available if needed)
    * `cat /proc/meminfo` is less human readable, but has more information
* RAM usage by process
    * `cat /proc/23231/status | grep VmSize`
    * `pmap 23231 | tail -n 1`
* RAM usage
    * `cd /sys/fs/cgroup/memory`
    * `ls` look at all the options:
        * `cat memory.max_usage_in_bytes`
        * `cat memory.usage_in_bytes`
        * `cat memory.stat`
* Disk load:
    * `iostat`
* CPU info:
    * `cat /proc/cpuinfo`
* GPU info:
    * `lshw -C display`
* List all storage devices and their partitions
    * `lsblk`
    * Sometimes it's possible to [increase available space](https://askubuntu.com/questions/1106795/ubuntu-server-18-04-lvm-out-of-space-with-improper-default-partitioning)

#### Network
* Shows ports in use
    * `netstat -tuplen`
        * Local Address `0.0.0.0:6080` / `:::6080` means its accessible from outside
        * Local Address `127.0.0.1:6080` means its accessible only from localhost
* Opens ports `80` and `443` in firewall
    ```
    firewall-cmd --permanent --zone=public --add-port=80/tcp
    firewall-cmd --permanent --zone=public --add-port=433/tcp
    firewall-cmd --reload
    ```
* Check reachability of a host
    * `ping google.com`
* Show path of an IP packet (to find where problem occurs)
    * `traceroute google.com`
* SSH, SCP
    * Commands moved to `devops` repository
* Download file from internet
    * `wget "https://apache-mirror.com/file.tar.gz"`
* Send get request
    * `curl https://example.com`
* Fully packed curl:
    * `curl --max-time 60 --verbose --fail --location example.com`
    * Timeout = 60 seconds; Verbose output; Returns non-zero exit code on errors; Follows redirects;
* Send anything to IP:PORT (TCP/IP)
    * `telnet 84.154.131.23 9200`
    * Often used to check availability
    * Escape character is `^]`. To produce `^]` press `Ctrl + ]`
    * Possible errors:
        * `Connection refused` - nothing listens on the port
        * `No route to host` - port blocked by firewall
        * `Network is unreachable` - IP actually unreachable
* Send anything to IP:PORT (UDP)
    * `nc -v -u -z -w 3 32.143.88.73 5050`
    * Should return something like `Connection to 32.143.88.73 5050 port [udp/sip] succeeded!`
* Get your IP address:
    * On local VMs - `ip addr | grep inet` (look for something like `inet 192.168.183.122/24 brd`)
        * Works even on local VMs
    * Standard - `curl ifconfig.co`
        * Works only with direct connection (otherwise will just show IP of your vpn/proxy/gateway)
* Local DNS:
    * In file `etc/hosts` insert `231.23.143.25 camel.keras.com`
* Check which DNS you use (changes with VPN)
    * `cat /etc/resolv.conf`
* Get domain name by IP address:
    * `nslookup` -> `93.184.216.34` (returns example.com)
* Find which DNS gave you the IP address:
    * `dig example.com`
    * `nslookup example.com`
* Redirect traffic (Port-forwarding)
    * `socat tcp-listen:9090,reuseaddr,fork tcp:localhost:8000`
    * For more info look at `devops` repository
* Show internet usage
    * Pick one: `apt-get install bmon slurm tcptrack`
* Change IP address:
    * Look at `cloud` repository, file `vSphere.md`
* Send SOAP request
    ```
    curl -X POST -H "Content-Type: text/xml" \
    --data-binary @request.xml \
    http://someamel.test.edias.som.ru/proxy/IMIS/IMIS/v5S/ProxyService \
    > response.xml
    ```
* Send POST request with JSON body
    ```
    curl \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"text":"Hello world!"}' \
    https://integram.org/webhook/dD3fFkdS2KL
    ```
* List current routes:
    * `route`, `netstat -r`, `ip route list` 
    * Routes should change after connecting to a vpn
* For more info about routes look at `vpn.md`
* CIDR - ip addressing scheme
    * `198.51.100.0/24` means all IP addresses from 198.51.100.0 to 198.51.100.255
    
#### Text
* Print text
    * Good - `printf "Hello \n world!`
    * Bad - `echo "Hello \n world!` (cant even handle linebreaks)
* Get third line of text:
    * `TELEGRAM_BODY=$(printf "$CI_COMMIT_MESSAGE" | sed -n 3p)`
* Get all text before `See merge request`
    * `TELEGRAM_BODY=${CI_COMMIT_DESCRIPTION%See merge request*}`
* Replace every occurrence of `Sam` with `Mike` in `report.txt`
    * `sed 's/Sam/Mike/g' report.txt > report_new.txt`
    * `sed -i 's/Sam/Mike/g' report.txt`
* Extract a 3rd column of text:
    * `ls -l | awk '{print $3}`
* Read/Edit text file
    * `nano /etc/config.toml`
    * `vim /etc/config.toml`
    * `less /etc/config.toml`
        * `/` - search forward; `?` - search backwards
        * `n` - next result; `N` - previous result
        * `v` - edit
* Find error in logs
    * Find lines with errors: 
        * `grep -n "Connection is not available" logs.txt`
        * Let's say error found at lines 1743, 2344, 3584
    * Get full response text (around line 1743)
        * `sed -n 1700,1800p logs.txt`
    
#### Special characters
* `&` - run in background
* `|` - pipe output of one command as input of another
* `;` - command separator
* `>` - output redirect
* `*` `?` - wildcards
* `#` - Comment
* `\` - Escape next character

#### Packages
* Find package manager:
    * Check linux distribution - `cat /etc/*-release`
        * Debian (Ubuntu) = `apt`
            * Manual - wget `.deb`, install with `dpkg -i`
        * Redhat = `dnf`, `microdnf`, `yum` (outdated)
            * Manual - wget `.rpm`, install with `rpm -i`
        * CentOS = `dnf`, `yum` (outdated)
            * Manual - wget `.rpm`, install with `rpm -i`
        * Alpine = `apk`
            * Manual - wget `.apk`, install with `apk add`
        * OpenSuSE = `zypper`
            * Manual - wget `.rpm`, install with `rpm -i`
        * Arch = `pacman`
            * Manual - wget `.pkg.tar.xz` install with `pacman -U`
        * Gentoo = `emerge`
            * Manual - wget `.ebuild` install with `ebuild install`
* Install Docker with different package managers:
    * `apt update && apt install docker.io`
    * `apk update && apk add docker`
    * `yum check-update && yum install docker`
    * `zypper refresh && zypper install docker.io`
* `snapd` - universal package manager (apps packaged with all their dependencies)
    * To run installed package - either just `openfortivpn` or `snap run openfortivpn`
* Download & install package manually (.deb):
    * `wget http://ftp.cz.debian.org/debian/pool/main/o/openfortivpn/openfortivpn_1.15.0-1_amd64.deb`
    * `dpkg -i openfortivpn_1.15.0-1_amd64.deb`
    * `openfortivpn --version`
* `apt` vs `apt-get` - high level vs low level

#### Docs
* Explain command, e.g. `netstat -tuplen`
    * https://explainshell.com/
* Typical usage (examples):
    * https://tldr.ostera.io or `tldr wget`
* Docs:
    * `ping --help`
    * `man wget`
    * `info wget` 

#### Others
* Set date/time:
    * `timedatectl set-time '2022-03-14 12:34:40'`
* Show info about linux distributive (version)
    * `cat /etc/*-release`
* Run docker-compose on OS start
    * `crontab -e`
    * Add line `@reboot cd /opt/highload && docker-compose up -d`
    * Logs - `grep CRON /var/log/syslog`
* Boot up file manager
    * `mc`
    * `ranger`
* Print environment variables
        * `printenv`
        * `echo $JAVA_HOME`
* Make long command readable (multiline):
    ```
    docker run \
        --network host \
        --add-host camel.test.keras.ru:32.2.121.43 \
        --name rest-backend \ 
        --env-file ./environment.list \
    rest-sp-back:1.0` 
    ```
* Add new root user:
    * Add user:
        * `adduser hofls`
    * Add user to group:
        * Get sudo group `cat /etc/sudoers` (e.g. root)
        * `usermod -aG root hofls` or `usermod -aG sudo hofls`
    * Optional - enable SSH password authentication:
        * `nano /etc/ssh/sshd_config`
            * Replace `PasswordAuthentication no` with `PasswordAuthentication yes`
        * `service ssh restart`
    * Test:
        * Connect with new user via ssh
        * `groups` /  `sudo su` / `ls -la /root`
        * Reboot may be required
* Change password:
    * To current user: `passwd`
    * To user jellyfish: `passwd jellyfish`
* Automate interaction with CLI programs - `Expect`
    * .e.g. wait for text `password:`, write `qwerty`