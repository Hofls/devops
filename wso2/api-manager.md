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
    * [Deployment.toml description](https://apim.docs.wso2.com/en/latest/reference/config-catalog/)
* Important files/folders:
    * Configs - `/opt/wso2am-4.2.0/repository/conf`
    * Logs - `/opt/wso2am-4.2.0/repository/logs`

### Install API Manager
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
  
    [[apim.gateway.environment]]
    http_endpoint = "http://123.165.77.188:${http.nio.port}"
    https_endpoint = "https://123.165.77.188:${https.nio.port}"
  
    [apim.devportal]
    url = "https://123.165.77.188:${mgt.transport.https.port}/devportal"
    ```
* Launch API Manager:
    * Copy [launcher](src/wso2-control.sh) to `/opt/wso2am-4.2.0/`
    * Start API Manager - `sh /opt/wso2am-4.2.0/wso2-control.sh start`
    * Check logs - `tail -f /opt/wso2am-4.2.0/repository/logs/wso2carbon.log`

### Test API Manager
* Open URLS:
    * Login/Password - `admin/admin`
    * https://123.165.77.188:9443/carbon
    * https://123.165.77.188:9443/publisher
    * https://123.165.77.188:9443/devportal
* `Publisher` and `Devportal` may throw error - `Registered callback does not match with the provided URL`. To fix it:
    * Open `Carbon` -> `Service Providers` -> `List` -> `Edit` -> `Inbound Authentication Configuration` -> `OAuth/OpenID Connect Configuration` -> `Edit`
    * In `Callback Url` replace `localhost` with server IP address - `123.165.77.188`; Press `Update`.
* Publish and subscribe to API:
    * Open `Publisher` -> `Create API` -> `Deploy Sample API`
    * Open `Devportal` -> `PizzaShackAPI` -> `TRY OUT` -> `TRY OUT` -> `GET TEST KEY` -> Execute endpoint `GET /menu`
    * If appears error `Failed to fetch` - check config section `[[apim.gateway.environment]]`
* Check links to devportal:
    * Open `Publisher` -> `PizzaShackAPI` -> `View in devportal`
    * If appears error `ERR_CONNECTION_REFUSED` - check config section `[apim.devportal]`
