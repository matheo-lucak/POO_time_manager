dev:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml up --build -d

prod:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up --build -d

stop:
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml stop
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml stop

logs:
	docker-compose logs -f

test: api-test app-test

##################################
##########   DEV API    ##########
##################################

api-test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml run api mix do deps.get, test

api-shell:
	docker exec -it tm_api bash

api-db-setup:
	docker exec tm_api mix ecto.setup

api-db-reset:
	docker exec tm_api mix ecto.reset

##############################
##########   APP    ##########
##############################

app-build:
	docker-compose build app

app-test:
	echo "Not implemented"
#	docker-compose run --rm app npm run test:unit