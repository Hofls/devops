* `-----BEGIN ENCRYPTED PRIVATE KEY-----`
    * `openssl req -x509 -newkey rsa:4096 -keyout key.pem -out encrypted-key.pem -sha256 -days 365`
* `-----BEGIN RSA PRIVATE KEY-----`
    * `openssl genrsa -out rsa-key.pem 3072`
* 