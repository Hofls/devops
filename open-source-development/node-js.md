### Node.js
* https://github.com/nodejs/node

#### Build
* https://github.com/nodejs/node/blob/master/BUILDING.md
* Install dependencies:
    ```
    sudo su
    apt update
    apt install python3 g++ make
    apt install nodejs
    ```
* Go to sources: `cd /mnt/hgfs/node`
* Configure: `./configure`
* Actions:
    * Build: `make -j4` (takes long time)
    * Run all tests: `make test-only` (takes long time)
    * Run specific test: `node ./test/parallel/test-stream2-transform.js`
    * Lint: `make lint`
    * Build documentation: `make doc`

#### Develop
* JavaScript locations:
    * Code: `lib`
    * Tests: `test/parallel`
