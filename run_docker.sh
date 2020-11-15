#!/bin/bash

# use the ssh keys on the host system

# to debug, add this line above the image name:
# -i -t --entrypoint /bin/bash

exec docker run \
     --rm \
     --name covid-19-stats-container \
     -v covid-19-stats-volume:"/app/project" \
     -v "$HOME/.ssh":"/root/.ssh" \
     -v "$(pwd)/service-account.json":"/root/service-account.json" \
     -v "$(pwd)/profiles.yml":"/root/.dbt/profiles.yml" \
     -v "$(pwd)/main.sh":"/app/main.sh" \
     --network net-covid19 \
     covid-19-stats-image
