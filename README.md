# grafana-jsonnet-test
Guinea pig repo for generating grafana dashboards from reusable jsonnet based panes

## Goal
Run grafana using reusable dashboard panels

## How it works?
Each panel is defined as jsonnet file so that can be imported into other panels.
jsonnet bundler, makes sure to bundle it all nicely together.
jsonnet gets rendered to json in the builder image.

