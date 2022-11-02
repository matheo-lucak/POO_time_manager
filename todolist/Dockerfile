# ---- Base Stage ----
FROM hexpm/elixir:1.12.3-erlang-24.1.2-alpine-3.14.2 AS base

# Set environment variables for building the application
RUN apk add --no-cache build-base git python3 curl

WORKDIR /app
ARG MIX_ENV=prod

RUN mix local.hex --force
RUN mix local.rebar --force

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix deps.compile
RUN mix phx.digest
RUN mix release

# ---- Application Stage ----
FROM alpine:3.14.2 AS app_prod

ARG MIX_ENV=prod
ARG DATABASE_URL="postgres://postgres:postgres@db:5432/todolist_dev"
ARG SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV PORT="${API_PORT}"
EXPOSE "${PORT}"

# install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

ENV USER="elixir"
ENV PHX_SERVER=1

WORKDIR "/home/${USER}/app"

# Create  unprivileged user to run the release
RUN \
  addgroup \
   -g 1000 \
   -S "${USER}" \
  && adduser \
   -s /bin/sh \
   -u 1000 \
   -G "${USER}" \
   -h "/home/${USER}" \
   -D "${USER}" \
  && su "${USER}"

# run as user
USER "${USER}"

# copy release executables
COPY --from=base --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/todolist ./

ENTRYPOINT ["bin/todolist"]

CMD ["start"]

# ---- Application Stage ----
FROM elixir:latest as app_dev

ARG MIX_ENV=dev
ENV PORT="${API_PORT}"
EXPOSE "${API_PORT}"

RUN apt-get update && \
    apt-get install -y postgresql-client

RUN mix local.hex --force

COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /api

# Run the Phoenix app
ENTRYPOINT ["bash", "./entrypoint.sh"]

# ---- Application Stage ----
FROM base as app_test

ARG MIX_ENV=test
ENV PORT="${API_PORT}"
EXPOSE "${API_PORT}"

COPY test ./test

WORKDIR /app
