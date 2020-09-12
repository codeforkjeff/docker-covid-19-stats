#!/bin/bash

# main script to run in container

if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR=~
fi

echo Using project directory: $PROJECT_DIR

## clone or update

cd $PROJECT_DIR

if [ ! -d "covid-19-stats" ]; then
    git clone git@github.com:codeforkjeff/covid-19-stats.git
fi

## clone or update

cd $PROJECT_DIR

if [ ! -d "COVID-19" ]; then
    git clone git@github.com:CSSEGISandData/COVID-19.git
fi

## make sure repo is up to date

cd $PROJECT_DIR/covid-19-stats
git pull

# build

make depend
make

# commit

echo "Contents of data dir"
ls -al data

git commit -m "data update" data/
git push
