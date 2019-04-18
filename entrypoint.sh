#!/bin/bash -e

if [ "$1" = "lint" ]; then
    exec flake8 backend
elif [ "$1" = "test" ]; then
    exec nosetests backend
elif [ "$1" = "typehinting" ]; then
    exec mypy backend
elif [ "$1" = "server" ]; then
    exec gunicorn \
	 --access-logfile - \
	 --bind 0.0.0.0:80 \
	 --user nobody \
	 --group nobody \
	 --workers 4 \
	 --timeout 6 \
	 --graceful-timeout 6 \
	 "backend.wsgi:app"
elif [ "$1" = "shell" ]; then
    exec /bin/bash
else
    exec /bin/bash -c "$*"
fi