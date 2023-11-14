FROM golang:1.21.4-alpine3.18 AS builder

RUN apk add git

ENV GO111MODULE=on
WORKDIR /src
COPY ./db/migrations /database
COPY infrastructure/migrate.sh /src

RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest