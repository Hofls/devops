### Gitlab API
##### Getting started
* Get token with
    * https://INSERT_GITLAB_URL_HERE/-/profile/personal_access_tokens
    * Select `api` scope
    * Example - `asd2-ldfjs83SjlwqSONSZldne`
* Get project ID (from project page)
    * Example - `5431`
* Find API URL, something like:
    * `https://INSERT_GITLAB_URL_HERE/api/v4/projects`
* List branches via browser console:
```
fetch("https://INSERT_GITLAB_URL_HERE/api/v4/projects/5431/repository/branches", {
  "headers": {
    "PRIVATE-TOKEN": "asd2-ldfjs83SjlwqSONSZldne"
  },
  "method": "GET"
});
```

##### Scripts
* Replace test branch for a bunch of microservices - [test-branch.js](test-branch.js)
* Create new release branch for a bunch of microservices - [release-branch.js](release-branch.js)
