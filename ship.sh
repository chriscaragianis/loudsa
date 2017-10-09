#! /usr/local/bin/zsh

mix docker.build
mix docker.release
docker tag loudsa-dev:release chriscaragianis/loudsa-dev:latest
sudo docker push chriscaragianis/loudsa-dev
