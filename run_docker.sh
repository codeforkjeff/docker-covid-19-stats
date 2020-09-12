#!/bin/bash

# use the ssh keys on the host system

exec docker run \
     --rm \
     --name covid-19-stats-container \
     -v covid-19-stats-volume:"/app/project" \
     -v "$HOME/.ssh":"/root/.ssh" \
     covid-19-stats-image
