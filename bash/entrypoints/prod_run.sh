#!/bin/bash
./app/manage.py migrate                  # Apply database migrations
./app/manage.py collectstatic --noinput  # Collect static files

# Prepare log files and start outputting logs to stdout
mkdir /var/log/$APP_NAME
touch /var/log/$APP_NAME/gunicorn.log
touch /var/log/$APP_NAME/access.log
tail -f /var/log/$APP_NAME/*.log &

# Start Gunicorn processes
# We can use "*" for forwared-allow-ips only because we are not exposing
# 8000 outside of the VPN
echo Starting Gunicorn.
cd app
exec gunicorn $APP_NAME.wsgi:application \
    --name $APP_NAME \
    --bind 0.0.0.0:8000 \
    --forwarded-allow-ips=* \
    --timeout 300 \
    --workers 3 \
    --log-level=info \
    --log-file=/var/log/$APP_NAME/gunicorn.log \
    --access-logfile=/var/log/$APP_NAME/access.log \
    "$@"
