* Render template with multiple values (e.g. common & test, common & stage)
    * Copy files to the server
    * `helm template multiple-values -f multiple-values/values-common.yaml -f multiple-values/values-test.yaml`