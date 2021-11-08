## Getting started
### Installation
* `apt update`
* `apt install ansible`
* `ansible --version`

### Hello world
* Make sure you can connect to remote host `ssh hofls@123.34.121.85`
    * If you have troubles - read [this](../../remote-access/ssh/linux-to-linux.md)
* Make sure that remote host has `python (v2)` installed
* Add host to the inventory `/etc/ansible/hosts`
* Check if ansible is able to connect to all hosts:
    * `ansible all -m ping -u hofls`
* Execute command `echo` on all hosts:
    * `ansible all -a "echo Hello world!" -u hofls`

### Hello world. Playbook
* Create file `playbook.yml` with following content:
    ```
    ---
    - name: This is a hello-world example
      hosts: all
      remote_user: hofls
      become: true
  
      tasks:
        - name: Create a file called '/tmp/hola.txt' with the content 'Hello world!'
          copy:
            content: Hello world!
            dest: /tmp/hola.txt
    ```
* Execute a playbook `ansible-playbook playbook.yml`