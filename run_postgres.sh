#!/bin/bash

# set /dev/shm size to 1g to prevent postgres errors:
# "could not resize shared memory segment "/PostgreSQL.463269227" to 8388608 bytes: No space left on device"

exec docker run \
       --name covid19-postgres \
       -e POSTGRES_PASSWORD=zzz \
       -d \
       --restart always \
       -v "$PWD/postgres.conf":/etc/postgresql/postgresql.conf \
       -v covid19-pgdata-volume:/var/lib/postgresql/data \
       --network net-covid19 \
       --shm-size=1g \
       postgres:12.4 \
       -c 'config_file=/etc/postgresql/postgresql.conf'
