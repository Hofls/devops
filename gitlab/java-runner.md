### Info
* You push code to gitlab. Some other server with installed gitlab-runner notices changes, pulls code and builds it.
    * Then server can deploy artifacts to dev/test/prod server (via e.g. `scp`)
* OS - CentOS 7
* Programming language - Java 15
* Build system - Maven
    * Local Maven repository (Cache) located at `/root/.m2/repository`

### Installation, configuration
#### [Install Java](https://jdk.java.net/15/)
* cd /opt
* wget "https://download.java.net/java/GA/jdk15.0.1/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-15.0.1_linux-x64_bin.tar.gz"
* tar xvf openjdk-15.0.1_linux-x64_bin.tar.gz
* export JAVA_HOME=/opt/jdk-15.0.1
* export PATH=$JAVA_HOME/bin:$PATH
* java -version

#### [Install Maven](https://maven.apache.org/install.html)
* cd /opt
* wget "https://apache-mirror.rbc.ru/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz"
* tar xzvf apache-maven-3.6.3-bin.tar.gz
* export M2_HOME=/opt/apache-maven-3.6.3/
* export M2=$M2_HOME/bin
* export PATH=$M2:$PATH

#### Optional. Update Git version
* yum remove git
* yum install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
* yum install git
* git --version

#### [Install Gitlab Runner](https://docs.gitlab.com/runner/install/linux-repository.html)
* curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
* export GITLAB_RUNNER_DISABLE_SKEL=true; sudo -E yum install gitlab-runner

#### [Configure Gitlab Runner](https://docs.gitlab.com/runner/register/index.html)
* sudo gitlab-runner register
    * Coordinator URL и token [e.g.](https://vcs.your-company.com/groups/your-project/-/settings/ci_cd)
    * Description: fresh openjdk runner
    * Tags: jvm, linux, openjdk
    * Executor: shell
* nano /etc/gitlab-runner/config.toml
    * Insert text in [[runners]]:
        ```
        limit = 1
        environment = ["JAVA_HOME=/opt/jdk-15.0.1", "M2_HOME=/opt/apache-maven-3.6.3/", "M2=$M2_HOME/bin"]
        pre_build_script = "export PATH=$JAVA_HOME/bin:$PATH && export PATH=$M2:$PATH"
        ```
#### Gitlab Runner Commands
* Launch
    * Make sure its is not running - ps aux | grep gitlab 
    * cd /opt
    * sudo gitlab-runner run &
