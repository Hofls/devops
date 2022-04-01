* Deploy to stage only from branches like release-1.3.0 and hotfix-2.4.7
```
deploy.stage:
  stage: deploy
  rules:
    - if: '$CI_COMMIT_BRANCH =~ /^release-.*$/ || $CI_COMMIT_BRANCH =~ /^hotfix-.*$/'
      when: always
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
    if git log -n 1 | grep -q -e 'jira.hofls.ru' -e 'Merge branch'; then
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