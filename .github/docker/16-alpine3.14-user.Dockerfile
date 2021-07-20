FROM node:16-alpine3.14

# the base image adds user node
# see: https://github.com/nodejs/docker-node/blob/ce3bb541693325ee21e38184873ceb4364b3e6f4/16/alpine3.14/Dockerfile
USER node
