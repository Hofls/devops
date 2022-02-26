### Info
* Chart structure:
    * `templates/` - templates folder
        * `deployment.yaml`, `service.yaml`, `ingress.yaml`: 
            * Template for creating k8s deployment/service/ingress etc
        * `_helpers.tpl` - common template functions
    * `Chart.yaml` - description of the chart
    * `values.yaml` - used to replace placeholders in templates
* How templates work:
    * Input (template):
        * `name: {{ .Values.UserName | lower | quote }}`
    * Output (yaml for k8s):
        * `name: "hofls"`
    * Helm takes template, replaces placeholder (.Values.UserName) with value ("hofls" from values.yaml) 
    * Executes functions (value to lower case, adds quotes)
* [Template function list](https://helm.sh/docs/chart_template_guide/function_list/)
* [Flow control](https://helm.sh/docs/chart_template_guide/control_structures/)
