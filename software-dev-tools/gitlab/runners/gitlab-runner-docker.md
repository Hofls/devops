# TODO
* Create folder /opt/gitlab-runner-config
* docker run -d --name gitlab-runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v /opt/gitlab-runner-config/:/etc/gitlab-runner gitlab/gitlab-runner:v13.10.0
* Periodically clean old images/volumes (e.g. via cron)
    * Look at `Smart removal` in `docker.md`
