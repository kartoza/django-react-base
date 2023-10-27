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
	@if [ ! -f deployment/docker-compose.override.yml ]; then \
    		cp deployment/docker-compose.override.template.yml deployment/docker-compose.override.yml; \
    		echo "File docker-compose.override.yml was created from template."; \
    	fi
	@docker-compose ${ARGS} up -d db dev worker

serve:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Execute webpack serve command"
	@echo "------------------------------------------------------------------"
	@docker-compose ${ARGS} exec -T dev npm --prefix /home/web/django_project/frontend run serve
