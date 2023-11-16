FROM golang:1.21.4-alpine3.18 AS builder

# Install required packages
RUN apk --no-cache add \
    bash \
    curl \
    git

# Install required packages
RUN apk --no-cache add \
    bash \
    gcc \
    python3 \
    python3-dev \
    musl-dev \
    linux-headers \
    libffi-dev \
    py3-pip

# Upgrade pip
RUN pip3 install --upgrade pip

# Install Azure CLI
RUN pip3 install azure-cli

ENV GO111MODULE=on
WORKDIR /src
COPY ./db/migrations /database
COPY infrastructure/migrate.sh /src

RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
