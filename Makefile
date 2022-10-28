start:
	docker-compose up -d

stop:
	docker-compose down

build: api-build

logs:
	docker-compose logs -f

test: api-test app-test

setup: api-setup

##############################
##########   API    ##########
##############################

api-build:
	docker-compose build api

api-shell:
	docker-compose run --rm api bash

api-test:
	MIX_ENV=test docker-compose run --rm api mix test

api-setup: api-build api-install api-compile api-db-setup

api-install:
	docker-compose run --rm api mix deps.get

api-compile:
	docker-compose run --rm api bash -c "mix do compile, phx.digest"

api-db-setup:
	docker-compose run --rm api mix ecto.setup

api-db-reset:
	docker-compose run --rm api mix ecto.reset

api-start-interactive:
	docker-compose run --rm --service-ports api iex -S mix phx.server

##############################
##########   APP    ##########
##############################

app-build:
	docker-compose build app

app-test:
	echo "Not implemented"
#	docker-compose run --rm app npm run test:unit