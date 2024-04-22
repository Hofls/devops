# Data migration from 2.6.0 to 4.2.0

### Transfer users, keys, tokens and secrets
* Transfer users:
    * Preparation (2.6.0):
        * Get lest of users (login + password)
    * Transfer (4.2.0):
        * Carbon -> Users and Roles -> Add -> Add New User -> Copy Username/Password
        * User and Roles -> List -> Users -> Assign Roles -> Internal/subscriber
* Transfer keys, tokens and secrets:
    * Preparation (2.6.0):
        * Login into store -> Applications -> DefaultApplication -> Copy all values
            * Consumer Key - `tXVHcsZe9qI7777I997hGO_fQGUa`
            * Consumer Secret - `PgJge6N7777YZh0J8Qb8ICxLx70a`
            * Access Token - `20708561-31ab-7777-bb72-559e9923f774`
    * Preparation (4.2.0):
        * Login into devportal as a new user
        * Applications -> DefaultApplication -> Production Keys -> Generate Keys -> Copy ConsumerKey
            * `QTzioDUi7777i3AEOxeTfcFrxVYa`
        * Applications -> DefaultApplication -> Production Keys -> Generate Keys -> Generate Access Token
            * `01ddfa16-c365-7777-8d02-0431456e9558`
        * APIs -> PizzaShackApi -> Try Out -> Insert access token -> Execute `GET /menu` (for both tokens)
    * Transfer:
        * Replace values in keys-transfer.sql script with real ones
        * Execute [keys-transfer.sql](src/keys-transfer.sql)

### Transfer API + subscriptions
* TODO - via Playwright (transfer data from old UI to new UI)
