# WSO2. API Manager
### Info
* Use case - you have a lot of servers with APIs and a lot of systems that use those APIs.
* Built on top of OSGI framework `Carbon` (modular architecture, where application = bunch of jar files)
* API Manager components:
    * `API Publisher` - publish API, monetize, limit rates
    * `API Developer Portal` - app store for apis
        * Allows publishers to advertise their APIs
        * Allows consumers to discover, evaluate and consume APIs
    * `Management Console (Carbon)` - admin panel, where you can add/configure almost everything
* Documentation:
    * [API Manager 4.2.0](https://apim.docs.wso2.com/en/4.2.0/)
    * [Architecture](https://apim.docs.wso2.com/en/latest/get-started/apim-architecture/)
    * [Install + Quick start](https://apim.docs.wso2.com/en/latest/get-started/api-manager-quick-start-guide/)
    * [Detailed installation guides](https://apim.docs.wso2.com/en/latest/install-and-setup/install-and-setup-overview/)
    * [Observability (logs/metrics)](https://apim.docs.wso2.com/en/latest/observe/observe-overview/)
* Important files/folders:
    * Configs - `/opt/wso2am-4.2.0/repository/conf`
    * Logs - `/opt/wso2am-4.2.0/repository/logs`

### Getting started (Ubuntu)
* Install JDK:
    ```
    cd /opt
    wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
    tar -xvf openjdk-17.0.2_linux-x64_bin.tar.gz
    export JAVA_HOME=/opt/jdk-17.0.2
    export PATH=$JAVA_HOME/bin:$PATH
    source ~/.bashrc
    java --version
    ```
* Install API Manager:
    * Download archive [wso2am-4.2.0](https://wso2.com/api-management/), unzip, put everything in `/opt` folder on server
    * `unzip wso2am-4.2.0.zip`
    * `chmod a+x /opt/wso2am-4.2.0/bin/api-manager.sh`
* Change hostname to your server IP:
    * `nano /opt/wso2am-4.2.0/repository/conf/deployment.toml`, change:
    ```
    [server]
    hostname = "123.165.77.188"
    ```
* Run API Manager - `sh /opt/wso2am-4.2.0/bin/api-manager.sh`
* Open URLS:
    * Login/Password - `admin/admin`
    * https://YOUR_SERVER_IP:9443/carbon
    * https://YOUR_SERVER_IP:9443/publisher
    * https://YOUR_SERVER_IP:9443/devportal
* Publisher and devportal throw error - `Registered callback does not match with the provided URL`. To fix it:
    * Open carbon -> `Service Providers` -> `List` -> `Edit` -> `Inbound Authentication Configuration` -> `OAuth/OpenID Connect Configuration` -> `Edit`
    * In `Callback Url` replace `localhost` with you server IP address - `123.165.77.188`; Press `Update`.

