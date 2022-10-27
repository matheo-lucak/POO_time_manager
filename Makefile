start:
	docker-compose up -d

stop:
	docker-compose down

build: api-build

logs:
	docker-compose logs -f

test: api-test app-test

##############################
##########   API    ##########
##############################

api-build:
	docker-compose build api

api-shell:
	docker-compose run --rm api bash

api-db-reset:
	docker-compose run api mix ecto.reset

api-start-iteractive:
	docker-compose run --rm --service-ports api iex -S mix phx.server

api-test:
	MIX_ENV=test docker-compose run api mix test

##############################
##########   APP    ##########
##############################

app-build:
	docker-compose build app

app-test:
	echo "Not implemented"
#	docker-compose run --rm app npm run test:unit