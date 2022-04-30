#### Telegram
* Add `@gitlab_bot` to your telegram group
* Send `/start`, bot will respond with link https://integram.org/gitlab/s3Sf45kJe
* Add webhook:
    * `Gitlab -> Project -> Settings -> Webhooks -> Insert URL -> Add Webhook`
        * `URL` - https://integram.org/gitlab/s3Sf45kJe
        * `Merge request events` - check
        * `Job events` - check
        * `Pipeline events` - check

#### Another git (Mirror)
* Settings -> Repository -> Mirroring repositories
    * Git repository URL: `https://hofls@vcs.svias.nyc.com/scm/git/svias-deck2`
    * Password: `qwerty`
* Resulting URL will look like: `https://*****:*****@vcs.svias.nyc.com/scm/git/svias-deck2`