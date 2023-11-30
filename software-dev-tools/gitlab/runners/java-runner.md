### Info
* You push code to gitlab. Some other server with installed gitlab-runner notices changes, pulls code and builds it.
    * Then server can deploy artifacts to dev/test/prod server (via e.g. `scp`)
* OS - CentOS 7
* Programming language - Java 15
* Build system - Maven, local repository path^
    * Usually located at `/root/.m2/repository`
    * If building with runner - `/home/gitlab-runner/.m2/repository/`
* If you build with gradle, local repository path:
    * Usually located at `/root/.gradle/caches/modules-2/files-2.1`
    * If building with runner - `/home/gitlab-runner/.gradle/caches/modules-2/files-2.1`

### Installation, configuration
#### [Install Java](https://jdk.java.net/15/)
* cd /opt
* wget "https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gz"
* tar xvf openjdk-15.0.1_linux-x64_bin.tar.gz
* Set environment:
    * `nano /etc/environment`
    * `JAVA_HOME="/opt/jdk-15.0.1"`
    * Add to the end of PATH - `:/opt/jdk-15.0.1/bin`
    * Restart server - `reboot`
    * Check environment:
        * `java --version`
        * `echo $JAVA_HOME` 

#### [Install Maven](https://maven.apache.org/install.html)
* cd /opt
* wget "https://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz"
* tar xzvf apache-maven-3.6.3-bin.tar.gz
* Set environment:
    * `nano /etc/environment`
    * `M2_HOME="/opt/apache-maven-3.6.3/"`
    * `M2="/opt/apache-maven-3.6.3/bin"`
    * Add to the end of PATH - `:/opt/apache-maven-3.6.3/bin`
    * Restart server - `reboot`
    * Check environment:
        * `mvn -version`
        * `echo $M2_HOME`
        * `echo $M2`

#### Install docker
* yum check-update
* yum install docker
* systemctl start docker
* chmod 777 /var/run/docker.sock
* docker -v; docker images

#### Optional. Update Git version
* yum remove git
* yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
* yum install git
* git --version

#### [Install Gitlab Runner](https://docs.gitlab.com/runner/install/linux-repository.html)
* curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
* export GITLAB_RUNNER_DISABLE_SKEL=true; sudo -E yum install gitlab-runner
* gitlab-runner -v

#### [Configure Gitlab Runner](https://docs.gitlab.com/runner/register/index.html)
* sudo gitlab-runner register
    * Token located here: 
        * [Old gitlab](https://vcs.your-company.com/groups/your-group/-/settings/ci_cd)
        * [New gitlab](https://vcs.your-company.com/groups/your-group/-/runners)
    * Description: fresh openjdk runner
    * Tags: jvm, linux, openjdk
    * Executor: shell
* nano /etc/gitlab-runner/config.toml
    * Insert text in [[runners]]: `limit = 1`
    * Optional. To override environment variables:
        ```
        environment = ["JAVA_HOME=/opt/jdk-15.0.1", "M2_HOME=/opt/apache-maven-3.6.3/", "M2=$M2_HOME/bin"]
        pre_build_script = "export PATH=$JAVA_HOME/bin:$PATH && export PATH=$M2:$PATH"
        ```
#### Gitlab Runner Commands
* Launch
    * Option A:
        * Make sure its not running - `ps aux | grep gitlab`
        * `cd /opt`
        * `sudo gitlab-runner run &`
    * Option B:
        * Make sure its not running - `systemctl status gitlab-runner`
        * `systemctl start gitlab-runner`

#### Common problems
* Build runner is resource hungry, should have small limit; Deploy runner need no resources, should have big limit
    * In first line of config set `concurrent = 12` (max 12 concurrent jobs)
    * In builder `[[runners]]` set `limit = 2` (max 2 builds in parallel)
    * In deployer `[[runners]]` set `limit = 10` (max 10 deployments in parallel)
* Runner quits without showing logs
    * Add sleep after_script to `.gitlab-ci.yml` (example at `tests` repository)