# docker build . -t covid-19-stats-image

FROM ubuntu:20.04

RUN apt update && apt-get -y install git make python3 python3-pip python3-venv sqlite3 vim virtualenvwrapper

RUN git config --global user.email "jeff@codefork.com"
RUN git config --global user.name "codeforkjeff"

ENV WORKON_HOME /root/.virtualenvs

RUN mkdir /root/.dbt

RUN mkdir /app

WORKDIR /app

VOLUME /app/project

ENV PROJECT_DIR /app/project

# paths must exist as files otherwise -v option in "docker run" will create dirs
RUN touch /root/.dbt/profiles.yml
RUN touch /root/service-account.json
RUN touch /app/main.sh

ENTRYPOINT /app/main.sh
