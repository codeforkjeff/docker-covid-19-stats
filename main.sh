#!/bin/bash

# main script to run in container

echo "Running at `date`"

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

## venv

cd $PROJECT_DIR

if [ ! -d "covid19-env" ]; then
    python3 -m venv covid19-env
fi
. $PROJECT_DIR/covid19-env/bin/activate


## make sure repo is up to date

cd $PROJECT_DIR/covid-19-stats
git pull

if [ ! -f $PROJECT_DIR/installed_python_packages ] || [ $PROJECT_DIR/covid-19-stats/requirements.txt -nt $PROJECT_DIR/installed_python_packages ]; then
    pip3 install -r requirements.txt
    touch $PROJECT_DIR/installed_python_packages
fi

## set up dbt profile

mkdir -p ~/.dbt
cat <<EOF > ~/.dbt/profiles.yml
covid19:
  outputs:

    dev:
      type: postgres
      threads: 2
      host: covid19-postgres
      port: 5432
      user: postgres
      pass: zzz
      dbname: covid19
      schema: public

    prod:
      type: redshift
      method: iam
      cluster_id: [cluster_id]
      threads: [1 or more]
      host: [host]
      port: [port]
      user: [prod_user]
      dbname: [dbname]
      schema: [prod_schema]

  target: dev
EOF

# build

make extract
make load
make transform
make export

# commit

echo "Contents of data dir"
ls -al data

git commit -m "data update" data/
git push
