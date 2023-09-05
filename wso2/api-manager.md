# WSO2. API Manager
### Info
* Use case - you have a lot of servers with APIs and a lot of systems that use those APIs.
* How it works?
    * API Manager is a middleman. Typical request path: Client -> WSO2 API Manager -> Server. 
    * WSO2 checks token and privileges, applies rate limiting. Only if everything is ok - sends request to server, returns response to client
* API Manager components:
    * `API Publisher` - publish API, monetize, limit rates (for producers)
    * `API Developer Portal` - discover APIs, subscribe and try them out (for consumers)
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
        * `/conf/deployment.toml`
        * `/conf/datasources/master-datasources.xml`
    * Logs - `/opt/wso2am-4.2.0/repository/logs`
    * H2DB - `/opt/wso2am-4.2.0/repository/database`

### Install API Manager
* Install JDK:
    ```
    cd /opt
    wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
    tar -xvf openjdk-17.0.2_linux-x64_bin.tar.gz
    /opt/jdk-17.0.2/bin/java --version
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
    * Copy [launcher](src/wso2-control.sh) to `/opt/`
    * Start API Manager:
        ```
        chmod a+x /opt/wso2-control.sh
        mv /opt/wso2-control.sh /opt/wso2am-4.2.0/
        sh /opt/wso2am-4.2.0/wso2-control.sh start
        ```
    * Check logs - `tail -f /opt/wso2am-4.2.0/repository/logs/wso2carbon.log`
    * Check carbon - `curl -k -L https://123.165.77.188:9443/carbon`

### Test & Configure API Manager
* Open URLS in web browser:
    * Login/Password - `admin/admin`
    * https://123.165.77.188:9443/carbon
    * https://123.165.77.188:9443/publisher
    * https://123.165.77.188:9443/devportal
* Publish and subscribe to API (sample):
    * Open `Publisher` -> `Create API` -> `Deploy Sample API`
    * Open `Devportal` -> `PizzaShackAPI` -> `TRY OUT` -> `TRY OUT` -> `GET TEST KEY` -> Execute endpoint `GET /menu`
    * If appears error `Failed to fetch` - check config section `[[apim.gateway.environment]]`
* Publish and subscribe to API (external):
    * Open `Publisher` -> `Create API` -> `Import Open API` -> `OpenAPI URL` -> Insert `https://petstore.swagger.io/v2/swagger.json` -> `Next`
    * `Context` -> Insert `/petstore` -> `Endpoint` -> Insert `https://petstore.swagger.io/v2` -> `Create`
    * `Business Plan` -> `Unlimited` -> `Deploy` -> `Try Out` -> Execute `GET /store/inventory`
    * If appears error `404 Not Found`, check `Endpoint` field
* Check links to devportal:
    * Open `Publisher` -> `PizzaShackAPI` -> `View in devportal`
    * If appears error `ERR_CONNECTION_REFUSED` - check config section `[apim.devportal]`
* `Publisher` and `Devportal` may throw error - `Registered callback does not match with the provided URL`. To fix it:
    * Open `Carbon` -> `Service Providers` -> `List` -> `Edit` -> `Inbound Authentication Configuration` -> `OAuth/OpenID Connect Configuration` -> `Edit`
    * In `Callback Url` replace `localhost` with server IP address - `123.165.77.188`; Press `Update`.
* Set tokens expiry time:
    * Open `Devportal` -> `Applications` -> `DefaultApplication` -> Production keys -> Put `3153600000` into all `Expiry Time` fields -> `Update`
    * You have to do it for each user
* If tokens are too long (100+ symbols) and they get deprecated after each generation:
    * Open `Carbon` -> `Service Providers` -> `List` -> Edit `admin_*_PRODUCTION` -> `Inbound Authentication Configuration`
        -> `OAuth/OpenID Connect Configuration` -> `Edit` -> Pick `Default` in `Token Issuer` field -> Update
    * You have to do it for each user
