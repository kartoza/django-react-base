export COMPOSE_FILE=deployment/docker-compose.yml:deployment/docker-compose.override.yml
SHELL := /bin/bash

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker-compose build

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker-compose ${ARGS} up -d nginx django

dev:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in dev mode"
	@echo "------------------------------------------------------------------"
	@docker-compose ${ARGS} up -d dev worker
	@docker-compose ${ARGS} up --no-recreate --no-deps -d
