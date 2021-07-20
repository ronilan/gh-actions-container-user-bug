# Checkout Action fails in container where image has defined USER

## Describe the bug
When using an image in container directive, if the image has defined a `USER` in the Dockerfile from which it was built, then the Checkout Action will fail since access to the repo is denied to user.

## To Reproduce
Steps to reproduce the behavior:

1. Go to test repo: https://github.com/ronilan/gh-actions-container-user-bug/
2. Inspect Dockerfiles in: https://github.com/ronilan/gh-actions-container-user-bug/tree/main/.github/docker
3. Run the Build Docker Images Action: https://github.com/ronilan/gh-actions-container-user-bug/actions/workflows/docker-node.yml
4. Run Container Matrix Checkout Action: https://github.com/ronilan/gh-actions-container-user-bug/actions/workflows/container.yml

Clone repo for further inspection/cases.

Five images are used. Three are from Dockerhub. Two were built using local Dockerfiles.
* `node:16`
* `node:16-alpine3.14`
* `ghcr.io/ronilan/gh-actions-container-user/node:16-alpine3.14-user`
* `ghcr.io/ronilan/gh-actions-container-user/node:16-user`
* `bitnami/laravel`

## Expected behavior
All Checkouts in matrix succeed.

## Runner Version and Platform
Current runner version: '2.278.0'
Operating System
  Ubuntu
  20.04.2
  LTS
Virtual Environment
  Environment: ubuntu-20.04
  Version: 20210712.0
  Included Software: https://github.com/actions/virtual-environments/blob/ubuntu20/20210712.0/images/linux/Ubuntu2004-README.md
  Image Release: https://github.com/actions/virtual-environments/releases/tag/ubuntu20%2F20210712.0

## What's not working?
Images where `USER` has been defined in Dockerfile fail the checkout step.
* `node:16` ✅
* `node:16-alpine3.14` ✅
* `ghcr.io/ronilan/gh-actions-container-user/node:16-alpine3.14-user` ❌
* `ghcr.io/ronilan/gh-actions-container-user/node:16-user` ❌
* `bitnami/laravel` ❌

## Job Log Output
```
Annotations
3 errors
job1 (ghcr.io/ronilan/gh-actions-container-user-bug/node:16-user)
The process '/usr/bin/git' failed with exit code 1
job1 (ghcr.io/ronilan/gh-actions-container-user-bug/node:16-alpine3.14-user)
EACCES: permission denied, open '/__w/gh-actions-container-user-bug/gh-actions-container-user-bug/ee081242-d865-45c5-8d69-2f00db47372f.tar.gz'
job1 (bitnami/laravel)
EACCES: permission denied, open '/__w/gh-actions-container-user-bug/gh-actions-container-user-bug/a074f4b8-f278-4a5f-a7da-96f62313ed1f.tar.gz'
```
