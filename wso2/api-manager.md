# WSO2. API Manager
### Info
* Use case - you have a lot of servers with APIs and a lot of systems that use those APIs.
* Built on top of OSGI framework `Carbon` (modular architecture, where application = bunch of jar files)
* API Manager components:
    * `API Publisher` - publish API, monetize, limit rates
    * `API Developer Portal` - app store for apis
        * Allows publishers to advertise their APIs
        * Allows consumers to discover, evaluate and consume APIs
    * `Service Catalog` - devs can register their services in a RESTful manner
* Documentation:
    * [API Manager 4.2.0](https://apim.docs.wso2.com/en/4.2.0/)
    * [Architecture](https://apim.docs.wso2.com/en/latest/get-started/apim-architecture/)
    * [Install + Quick start](https://apim.docs.wso2.com/en/latest/get-started/api-manager-quick-start-guide/)
    * [Detailed installation guides](https://apim.docs.wso2.com/en/latest/install-and-setup/install-and-setup-overview/)
    * [Observability (logs/metrics)](https://apim.docs.wso2.com/en/latest/observe/observe-overview/)

### Getting started (Ubuntu)
* Install JDK:
    ```
    cd /opt
    wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
    tar -xvf openjdk-17.0.2
    export JAVA_HOME=/opt/openjdk-17.0.2
    export PATH=$JAVA_HOME/bin:$PATH
    ???? source ~/.bashrc
    java --version
    ```
* Install API Manager:
    * Download archive [wso2am-4.2.0](https://wso2.com/api-management/), unzip, put everything in `/opt` folder on server
    * `cd /opt/wso2am-4.2.0/bin && chmod a+x api-manager.sh && sh api-manager.sh`
* Make sure API Manager is working:
    * https://localhost:9443/publisher
        * `admin/admin`
    * https://localhost:9443/devportal
        * `admin/admin`
* TODO - configure API Manager
* TODO - launch after restart via crontab
