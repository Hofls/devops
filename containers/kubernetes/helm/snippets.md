* Hosts (local DNS):
    * File `deployment.yaml`:
    ```
    {{- if .Values.hostAliases }}
    hostAliases:
      {{- toYaml .Values.hostAliases | nindent 8 }}
    {{- end }}
    ```
    * File `values.yaml`:
    ```
    hostAliases:
      - ip: "102.223.45.67"
        hostnames:
          - "users.someit.com"
          - "store.someit.com"
    ```
* 
* 