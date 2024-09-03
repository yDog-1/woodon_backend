FROM mcr.microsoft.com/devcontainers/go:1-1.23-bookworm

USER root

RUN apt-get update \
  && apt-get -y --no-install-recommends install postgresql \
  && apt-get -y --no-install-recommends install postgresql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER vscode

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin" v1.60.3 \
  && curl -sSfL https://raw.githubusercontent.com/air-verse/air/master/install.sh | sh -s -- -b "$(go env GOPATH)/bin"

RUN go install github.com/rubenv/sql-migrate/...@v1.7.0\
  && go install github.com/volatiletech/sqlboiler/v4@v4.16.2\
  && go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-psql@v4.16.2\
  && go install github.com/matryer/moq@v0.5.0\
  && go install github.com/99designs/gqlgen@v0.17.49

WORKDIR /app
COPY ../ .
# RUN go mod download