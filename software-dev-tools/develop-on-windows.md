## Develop on Windows, run on Linux

##### Develop locally. Overview
* If all you want to do is edit code and run tests, Windows is enough
    * Linux is must have to build and run code
* Use IDE on windows, sync files with Linux, run/build/test on Linux
    * Linux is great on server-side, windows is good on client-side
    * Free your local OS from need to install a bunch of software / config tweaks
    * Practically unlimited resources (on the cloud)
    * Possible pitfalls:
        * Use LF instead of CRLF on Windows
            * Global -`git config --global core.autocrlf false`
                * If you want to run everything on linux
            * Only specific file - `sed -i -e 's/\r$//' start_local_env.sh`
                * If you want to run main project on windows, with environment (e.g. kafka container) on linux
        * Path shouldn't have spaces or weird characters (e.g. cyrillic)

##### Develop locally. Visual Studio code server
* Run VS code:
    ```
    docker run -d \
      -e PUID=1000 -e PGID=1001 \
      -p 8443:8443 \
      -v /opt/vscode:/config \
      lscr.io/linuxserver/code-server
    ```
* Open in browser `http://YOUR_SERVER_IP:8443`
* Clone a project from github:
    * `cd /opt/vscode/workspace && mkdir fire && chmod 777 fire`
    * `Get Started` -> `Clone Git Repository` -> `https://github.com/firebase/codelab-friendlychat-web` -> `/config/workspace/fire`

##### Develop locally. Host-Guest
* Notice: this method has limitations (e.g. no symlinks)
    * Usable to run infrastructure (e.g. redis + kafka on docker), while main app runs on host
* `VMware Player`:
    * Install `VMware Player`
    * Download & install `Ubuntu` server image 
        * .iso - install yourself [(slow)](https://ubuntu.com/server)
            * File -> New Virtual Machine -> Installer disc image file (iso)
        * .vmdk - already installed [(fast)](https://www.osboxes.org/ubuntu-server/)
            * File -> New Virtual Machine -> I will install the OS later
            * Edit VM settings -> Add... -> Hard Disk -> Use an exiting virtual disk
            * Edit VM settings -> Pick old hard disk -> Remove
    * Folder & test file:
        * Create a folder `shared-folder` on host machine
        * Create `hello.py` file with content `print('Hello world!')`
    * Sync a folder:
        * Edit VM settings -> Options -> Shared Folders -> Always Enabled -> Add...
        * Run a VM
        * Execute on guest 
            * `mkdir /mnt/hgfs`
            * `vmhgfs-fuse .host:/ /mnt/hgfs/ -o allow_other -o uid=1000`
            * `cd /mnt/hgfs/shared-folder`
            * `python3 hello.py`
        * PS in some cases you have to execute command `vmhgfs-fuse` after each reboot
    * Access guest web-service (from the host)  
        * Get address: `ip addr | grep inet` (look for something like `inet 192.168.183.122/24 brd`)
        * Run web-service: `python3 -m http.server`
        * Open URL on the host: http://192.168.183.122:8000
* `Docker`:
    * TODO (Using volumes)

##### Develop locally. Client-Server / Host-Guest
* `IntelliJ IDEA`:
    * Configure SSH:
        * File -> Settings -> Tools -> SSH Configurations -> Add 
            * Name -> nodejs-ssh
            * Host -> 123.32.143.54
            * User name -> hofls
            * Authentication type -> Key pair
            * Private key file -> C:\keys\private_key.ppk
        * Test connection -> OK
    * Start SSH:
        * Tools -> Start SSH session -> nodejs-ssh
        * `sudo su`
        * `cd /opt; mkdir remote; chmod 777 remote`
    * Configure SFTP:
        * File -> Settings -> Build, Execution, Deployment -> Deployment
        * Add -> SFTP
            * Name -> nodejs-sftp
            * SSH configuration -> nodejs-ssh
            * Root Path -> /opt/remote
        * Mappings -> 
            * "Local path" -> C:\projects\open-source\nodejs\
            * "Deployment path" -> /
        * Test connection -> OK
    * Sync up:
        * Right click on `nodejs` folder -> Deployment -> Upload to 'temp'
            * Notice: if it's too slow - just use `git clone` on server
        * Tools -> Deployment -> Automatic upload
* `WinSCP`:
    * https://stackoverflow.com/questions/423362/best-way-to-instantly-mirror-sync-files-from-windows-to-linux-server
* `Rsync`:
    * https://stackoverflow.com/questions/423362/best-way-to-instantly-mirror-sync-files-from-windows-to-linux-server

##### Develop locally. WSL 
* TODO

##### Develop locally. Native
* Just install everything on windows, even linux CLI (`MinGW` comes bundled with git)
    * To convert CRLF to LF `sed -i -e 's/\r$//' script.sh`
