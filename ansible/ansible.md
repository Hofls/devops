https://docs.ansible.com/ansible/latest/user_guide/intro_getting_started.html

## Getting started
### Installation
* `apt update`
* `apt install ansible`
* `ansible --version`

### Hello world
* Make sure you can connect to remote host `ssh hofls@123.34.121.85`
    * If you have troubles - read [this](../ssh/linux-to-linux.md)
* Make sure that remote host has `python (v2)` installed
* Add host to `/etc/ansible/hosts`
* Check if ansible is able to connect to all hosts:
    * `ansible all -m ping -u hofls`
* Execute command `echo` on all hosts:
    * `ansible all -a "echo Hello world!" -u hofls`

