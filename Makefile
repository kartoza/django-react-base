export COMPOSE_FILE=deployment/docker-compose.yml:deployment/docker-compose.override.yml
SHELL := /bin/bash

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose build

up:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose ${ARGS} up -d nginx django

dev:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in dev mode"
	@echo "------------------------------------------------------------------"
	@docker compose ${ARGS} up -d dev worker

down:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Removing production instance!!! "
	@echo "------------------------------------------------------------------"
	@docker compose down

flake:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running flake8"
	@echo "------------------------------------------------------------------"
	@pip install flake8 flake8-docstrings pydoclint[flake8]
	@flake8

wait-db:
	@docker compose ${ARGS} exec -T db su - postgres -c "until pg_isready; do sleep 5; done"


frontend-test:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Run tests"
	@echo "------------------------------------------------------------------"
	@docker compose exec -T dev sh -c "cd /home/web/django_project/frontend && npm test"

# -----------------------------------------------------------------------------
# ----------------------------------- D E V -----------------------------------
# -----------------------------------------------------------------------------
dev-ci-test:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in DEVELOPMENT mode for CI test"
	@echo "------------------------------------------------------------------"
	@docker compose ${ARGS} up --no-recreate --no-deps -d db worker redis dev

dev-entrypoint:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running entrypoint.sh in DEVELOPMENT mode"
	@echo "------------------------------------------------------------------"
	@docker compose ${ARGS} exec -T dev "/home/web/django_project/entrypoint.sh"

dev-initialize:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running initialize.py in DEVELOPMENT mode"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) exec -T dev bash -c "python -u /home/web/django_project/initialize.py"

dev-runserver:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Start django runserver in dev container"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) exec -T dev bash -c "nohup python manage.py runserver 0.0.0.0:8080 &"

dev-test:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Run tests"
	@echo "------------------------------------------------------------------"
	@docker compose exec -T dev python manage.py test --keepdb --noinput