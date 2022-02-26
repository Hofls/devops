#### Images list
* [Linux with GUI (RDP)](https://github.com/linuxserver/docker-rdesktop)
    * `docker run --detach --publish 3389:3389 ghcr.io/linuxserver/rdesktop`
    * Open `Remote Desktop Connection`, insert `YOUR_SERVER_IP`, login/password - `abc/abc`
* [CentOS with GUI (VNC/noVNC)](https://github.com/ConSol/docker-headless-vnc-container)
    * `docker run -d -p 5901:5901 -p 6901:6901 consol/centos-xfce-vnc`
    * Open `http://YOUR_SERVER_IP:6901/`, password - `vncpassword`
* [Ubuntu with GUI (VNC/noVNC)](https://github.com/fcwu/docker-ubuntu-vnc-desktop)
    * `docker run -p 6080:80 -v /dev/shm:/dev/shm dorowu/ubuntu-desktop-lxde-vnc`
    * Open `http://YOUR_SERVER_IP:6080/`
* [Android emulator](https://github.com/budtmo/docker-android)
    * For details go to repository `tests`, path `/e2e-tests/android`
* [Web UI for Docker](https://github.com/portainer/portainer)
    * `docker volume create portainer_data`
    * `docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce`
    * Open `http://YOUR_SERVER_IP:9000/`
* [Web IDE (VS Code)](https://github.com/linuxserver/docker-code-server)
    * `docker run --detach --publish 8443:8443 ghcr.io/linuxserver/code-server`
    * Open `http://YOUR_SERVER_IP:8443/`
* [A dark room (Browser game)](https://github.com/doublespeakgames/adarkroom)
    * `docker run --publish 8080:80 dahuss/a-dark-room`
    * Open `http://YOUR_SERVER_IP:8080/`
* [Echo web server](https://github.com/Ealenn/Echo-Server)
    * `docker run -d -p 3000:80 ealen/echo-server`
    * Open `http://YOUR_SERVER_IP:3000/`

#### Custom
* Test container, runs forever
    ```
    FROM openjdk:15-alpine
    CMD tail -f /dev/null
    ```