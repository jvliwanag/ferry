#!/bin/bash

BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ "$SKIP_PROMPT" != "1" ]; then
  echo -n "This will set-up a new Meet system. All data will be erased. Continue? (y/n). "
  
  read CONTINUE
  if [ "$CONTINUE" != "y" ]; then
    echo "Aborting"
    exit 2
  fi
fi

cd "$BASEDIR"

echo "Stopping containers..."
fig stop

echo "Destroying containers..."
fig rm --force -v

echo "Clearing data..."
sudo rm -Rf data # TODO - remove sudo

echo "Copying seed data..."

# meet
mkdir -p data/meet
cp -R seed/meet/config.js data/meet

# openfire
mkdir -p data/openfire
cp -R seed/openfire/etc seed/openfire/lib data/openfire


echo "Recreating containers..."
fig up -d

echo "Stopping containers..."
fig stop

echo "Starting db..."
fig start db

echo "Waiting 3s..."
sleep 3

echo "Loading db seed data..."
MYSQL_HOST=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ferry_db_1) mysql -uopenfire -popenfire openfire < seed/db/openfire.sql

echo "Starting openfire..."
fig start openfire

echo "Waiting 5s"
sleep 5

echo "Starting videobridge..."
fig start videobridge

echo "Starting meet..."
fig start meet

echo "Reporting fig status..."
fig ps

echo "Done!"

