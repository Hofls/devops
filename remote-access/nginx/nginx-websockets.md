### Nginx with WebSockets
* [Install nginx](nginx.md)
* Use websocket via browser (in new tab):
    * Create websocket:
        * `const ws = new WebSocket('wss://ws.postman-echo.com/raw')`
    * Send message:
        ```
        ws.onmessage = (message) => {
          console.log(`message received`, message.data)
        }
        ws.send('hello world')
        ```
    * Go to Network tab to make sure that connection is alive
* Configure nginx:
    ```
    events {
    }
    http {
           server {
                    location /echo/ {
                            proxy_pass https://ws.postman-echo.com/raw;
                            proxy_set_header Upgrade "websocket";
                            proxy_set_header Connection "Upgrade";
                    }
            }
    }
    ```
* Use websocket via browser again, but this time:
    * Replace `ws.postman-echo.com/raw` with nginx address; Replace `wss` with `ws`
    * Something like `const ws = new WebSocket('ws://128.165.13.66/echo/')`
* Change timeout (how long websocket can stay inactive)
    * Add to config, below `proxy_set_header`:
        `proxy_read_timeout 5s;`
    * Use websocket again, now connection should die in 5 seconds
* Now you can prevent websocket timeouts (e.g. set `99999s`) 
    * Warning! Best solution is sending ping to websocket every 50 seconds (connection will always be active, no need to configure timeouts)
