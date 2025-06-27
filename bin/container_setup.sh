#!/bin/bash
set -e

# Apply DB schema migrations
./manage.py migrate

# Creates a default superuser account:
./manage.py shell < ./bin/setup_admin_user.py
