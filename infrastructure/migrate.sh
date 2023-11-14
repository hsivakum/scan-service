#!/usr/bin/env sh
if [ $? -eq 0 ]; then
    migrate -path /database -database postgres://"${DB_USER}":"${DB_PASSWORD}"@"${DB_HOST}":"${DB_PORT}"/"${DB_NAME}"?sslmode=disable -verbose up
else
    echo "Unable to retrieve password"
fi
