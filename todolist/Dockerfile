FROM elixir:latest

EXPOSE "${API_PORT}"
WORKDIR /api

RUN apt-get update && \
    apt-get install -y postgresql-client

RUN mix local.hex --force

COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile

CMD ["bash", "entrypoint.sh"]