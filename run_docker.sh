#!/bin/bash

# use the ssh keys on the host system

# to debug, add -i -t --entrypoint /bin/bash

exec docker run \
     --rm \
     --name covid-19-stats-container \
     -v covid-19-stats-volume:"/app/project" \
     -v "$HOME/.ssh":"/root/.ssh" \
     -v "service-account.json":"/root/service-account.json" \
     --network net-covid19 \
     covid-19-stats-image
