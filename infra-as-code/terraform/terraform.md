* `Terraform` - infrastructure as code software tool
* `Execution Plan` - description of actions that Terraform will take (for user approval)
* `Provider` - plugin to interact with service API and access its related resources (e.g. interact with AWS, Azure)
    * `Data Source` - implemented by providers to return information on external objects
* `Module` - folder with Terraform templates (configurations)
    * `Output Value` - return values of module that can be used by other modules
* `Resource` - infrastructure objects (e.g. compute instance)
* `State` - info about current state of managed infrastructure
* `Workflow`
    * `Write` - describe infrastructure as code (declarative)
    * `Plan` - preview changes before applying
    * `Apply` - provision infrastructure (change to desired state)
* `Lifecycle` - Init, Plan, Apply, Destroy