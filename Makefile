start:
	docker-compose up -d

stop:
	docker-compose down

build:
	docker-compose build api

shell:
	docker-compose run --rm api bash

logs:
	docker-compose logs -f

install:
	docker-compose run --rm api mix deps.get

compile:
	docker-compose run --rm api bash -c "mix do compile, phx.digest"

db-setup:
	docker-compose run --rm api mix ecto.setup

db-reset:
	docker-compose run --rm api mix ecto.reset

start-interactive:
	docker-compose run --rm --service-ports api iex -S mix phx.server

test:
	MIX_ENV=test docker-compose run --rm api mix test

setup: build install compile db-setup
