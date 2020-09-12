
# docker-covid-19-stats

Run data builds for [covid-19-stats](https://github.com/codeforkjeff/covid-19-stats) in Docker

This is just for my personal use, so a few things are hardcoded that probably shouldn't be.

# Instructions

(Re)build the image using the Dockerfile:

```
docker build . -t covid-19-stats-image
```

Run the code. This can be put in a cron job.

```
./run_docker.sh
```
