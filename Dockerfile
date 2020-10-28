# docker build . -t covid-19-stats-image

FROM ubuntu:20.04

RUN apt update

RUN apt-get -y install git make python3 sqlite3

RUN git config --global user.email "jeff@codefork.com"
RUN git config --global user.name "codeforkjeff"

RUN mkdir /app

WORKDIR /app

VOLUME /app/project

ENV PROJECT_DIR /app/project

COPY main.sh /app

ENTRYPOINT /app/main.sh

