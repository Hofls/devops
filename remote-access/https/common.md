#### HTTPS
* How it works:
    * Client gets public cert from server
    * Client verifies cert with CA (Certificate Authority)
    * Client and server exchange keys and messages to establish a secure connection
    * Now client can send encrypted requests and decrypt encrypted responses 
* `Self-signed certificate` - issued by owner of site, without CA
    * Secure connection is impossible, because client is unable to verify cert with CA
  