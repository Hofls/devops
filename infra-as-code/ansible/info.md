* `Ansible` - tool for IT infrastructure automation
* `Control node` 
    * any machine with Ansible installed
    * uses SSH to communicate with managed nodes
* `Managed node` - server that you manage with Ansible
* `Inventory` - list of managed nodes
* `Module` - code that Ansible executes (Plugin, Tool)
* `Task` - action (Command)
* `Playbook` - list of tasks (YAML)
    * Contains one or more `Plays` (sports analogy)
* `Role` - combination of tasks, handlers, variables
    * Adding `Role` to `Play` is a common use-case
