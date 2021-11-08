#### Overview
* `Chef Infra` - Infrastructure as code (declarative)
    * `Infra Client` - agent, runs on nodes under `Infra server` management, performs actions to bring node to an expected state
    * `Infra Server` - hub for configuration data (stores cookbooks, policies, templates, etc)
* `Cookbook` - description of desired system state
* 

#### Getting started
* Install `Chef Workstation`:
    * `wget https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb`
    * `dpkg -i chef-workstation_21.10.640-1_amd64.deb`
    * `chef --version`
* Generate `Chef Infra` repository:
    * `chef generate repo hello-world-repo`
    * `cd hello-world-repo`
    * `nano cookbooks/example/recipes/default.rb`
        ```
          file "/opt/message.txt" do
            content 'Hello world!'
          end
        ```
    * `chef-client --local-mode --override-runlist example`



#### todo
* https://learn.chef.io/courses/course-v1:chef+Infra101+perpetual/course/
* https://docs.chef.io/chef_overview/
* 
* 