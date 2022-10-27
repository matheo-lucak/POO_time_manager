start:
	docker-compose up -d

stop:
	docker-compose down

build: api-build

logs:
	docker-compose logs -f

test: api-test

##############################
##########   API    ##########
##############################

api-build:
	docker-compose build api

api-shell:
	docker-compose run --rm api bash

api-db-reset:
	docker-compose run --rm api mix ecto.reset

api-start-iteractive:
	docker-compose run --rm --service-ports api iex -S mix phx.server

api-test:
	MIX_ENV=test docker-compose run --rm api mix test