#### Info
* MinIO - Object storage (API compatible with Amazon S3)

#### Getting started
* Install & run:
    ```
    docker run \
    -p 9000:9000 -p 9001:9001 --detach \
    minio/minio server /data --console-address ":9001"
    ```
* Work in browser:
    * Open in web browser: `http://YOUR_SEVER_IP:9001`
    * Enter credentials - `minioadmin/minioadmin`
    * `Create Bucket` -> `Upload File` -> `Delete`
    * Other useful features - Monitoring, Configuration, Notifications, Profiling, Identity (Access)
