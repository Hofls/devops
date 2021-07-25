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
    - commit_message=$(git log --skip 1 -n 1 --format=%B)
    - echo $commit_message
    - curl "https://api.telegram.org/bot3284821321:dljas23828djasSDJLdsa2323D/sendMessage?chat_id=-348834772991&text=New changes: "$commit_message
  tags:
    - docker

```
