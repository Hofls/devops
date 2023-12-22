#### Telegram notifications
* `ifttt` - 15 minutes precision, it's too low
* `Cron` on your server - low level but flexible and precise

#### Cron
* Add telegram bot `@bullhorn_bot` to a group, send `/start@bullhorn_bot`
     * Get URL from response, e.g. - https://integram.org/webhook/cdKsSl2Df8s
* SSH to your server  
* `cd /opt; mkdir reminder; cd reminder; touch daily.sh; chmod 777 daily.sh`
* `nano daily.sh`
    ```
    curl \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"text":"It's daily time!"}' \
    https://integram.org/webhook/cdKsSl2Df8s
    ```
* `crontab -e`
    * `30 10 * * MON-FRI /opt/reminder/daily.sh`

#### Etc
* To get group id / chat id, add bot `@getmyid_bot`
* To manually send message via bot:
    * curl "https://api.telegram.org/bot238482123:SK82kjSklxcjz92SKSKSJDzcLSD/sendMessage?chat_id=-238478721&text=Hello world!";
    * curl "https://api.telegram.org/bot238482123:SK82kjSklxcjz92SKSKSJDzcLSD/sendMessage?chat_id=-238478721&parse_mode=html&text=Hello <b>world</b>!";
* 