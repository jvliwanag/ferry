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

while [ "$XMPP_DOMAIN" == "" ]; do
  echo -n "Enter XMPP domain: "
  read XMPP_DOMAIN
done

cd "$BASEDIR"

echo "Creating fig.yml..."
sed "s/%XMPP_DOMAIN%/$XMPP_DOMAIN/g" fig.yml.in > fig.yml

echo "Stopping containers..."
fig stop

echo "Destroying containers..."
fig rm --force -v

echo "Clearing data..."
sudo rm -Rf data # TODO - remove sudo

echo "Copying seed data..."

# meet
mkdir -p data/meet
sed "s/%XMPP_DOMAIN%/$XMPP_DOMAIN/g" seed/meet/config.js.in > data/meet/config.js

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
sed "s/%XMPP_DOMAIN%/$XMPP_DOMAIN/g" seed/db/openfire.sql.in | \
 MYSQL_HOST=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ferry_db_1) \
 mysql -uopenfire -popenfire openfire 

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

