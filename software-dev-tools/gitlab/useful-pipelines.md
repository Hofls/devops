* Deploy to stage only from branches like release-1.3.0 and hotfix-2.4.7
```
deploy.stage:
  stage: deploy
  rules:
    - if: '$CI_COMMIT_BRANCH =~ /^release-.*$/ || $CI_COMMIT_BRANCH =~ /^hotfix-.*$/'
      when: on_success
    - when: never
  script:
    - echo "hello world!"
```

* Make sure each commit has jira link:
```
check-commit-name:
  stage: build
  script:
  - >
    if git log -n 1 | grep -q -e 'jira.hofls.com' -e 'Merge branch' -e 'Merge remote-tracking'; then
      echo "Commit name is OK";
      exit 0;
    else
      echo "Problem found! There is no link to task in commit name";
      exit 1;
    fi
  tags:
  - jvm
```

* Sent notification after merge in develop
```
notify-about-changes:
  stage: build
  only:
    - develop
  script:
    - # Extract commit message from "Merge branch 'VOCDOC-2944' into 'develop'"
    - commit_message=$(git log -n 1 --format=%B | head -n 3 | tail -1)
    - curl "https://api.telegram.org/bot3284821321:dljas23828djasSDJLdsa2323D/sendMessage?chat_id=-348834772991&text=$commit_message"
  tags:
    - docker

```

* Only deploy API if it was changed
```
deploy-api:
  stage: deploy
  rules:
    - if: $CI_COMMIT_BRANCH == "develop"'
      changes:
        - backup-api/*
  script:
    - echo "deployment here!"
```

* Reduce duplication (reuse build-and-push.yml)
```
include:
  - project: somgan-tm/cd-templates
    ref: master
    file: build-and-push.yml
main.build-push-develop:
  extends: .build-push
  variables:
    IMAGE_PROJECT: develop
```

* Reduce duplication (reuse .deploy)
```
.deploy: &deploy
  stage: deploy
  script:
    - echo $MESSAGE
deploy-test:
  variables:
    MESSAGE: 'Deploying to test!'
  <<: *deploy
```

* Send notification about merged request to telegram
```
.notify:
  stage: notify
  script:
    - >
      if [ "$SEND_NOTIFICATION" != "true" ]; then
        exit 0;
      fi
    - TELEGRAM_HEADER="New version of service <b>$CI_PROJECT_TITLE</b> available! %0A %0A"
    - TELEGRAM_BODY=$(printf "$CI_COMMIT_MESSAGE" | sed -n 3p)
    - curl "https://api.telegram.org/bot4235655:Skilkj238dLSOSisjoqjw28443/sendMessage?chat_id=-38772194&parse_mode=html&text=$TELEGRAM_HEADER$TELEGRAM_BODY"
```

* Print all environment variables (useful for CI script development, e.g. - CI_PROJECT_TITLE, CI_COMMIT_MESSAGE)
```
.notify:
  stage: notify
  script:
    - export
```

* If variable = true, allow deployment only from release branch:
```
.deploy-from-release:
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: never
    - if: '$CI_COMMIT_BRANCH !~ /^release.*$/ && $DEPLOY_ONLY_FROM_RELEASE_BRANCH == "true"'
      when: never
    - when: manual
      allow_failure: true
deploy-kubernetes:
  extends: .deploy-from-release
  stage: deploy
  script:
    - echo "Deploying!"
```
