#!/bin/sh
set -e

if [ -f /app/tmp/pids/server.pid ]; then
  rm -f /app/tmp/pids/server.pid
fi

exec bundle exec "$@"
