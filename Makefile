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

api-shell:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm api sh

api-test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm api mix test

api-db-setup:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm api mix ecto.setup

api-db-reset:
	docker-compose -f docker-compose.yml -f docker-compose.dev.yml run --rm api mix ecto.reset

##############################
##########   APP    ##########
##############################

app-build:
	docker-compose build app

app-test:
	echo "Not implemented"
#	docker-compose run --rm app npm run test:unit