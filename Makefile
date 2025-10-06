export COMPOSE_FILE=deployment/docker-compose.yml:deployment/docker-compose.override.yml
SHELL := /bin/bash

# Paths for dev override/template
OVERRIDE_PATH := deployment/docker-compose.override.yml
OVERRIDE_TEMPLATE_PATH := deployment/docker-compose.override.template.yml

ENV_PATH := deployment/.env
ENV_TEMPLATE_PATH := deployment/.template.env

.PHONY: build up dev down flake wait-db frontend-test dev-ci-test dev-entrypoint dev-initialize dev-runserver dev-test sleep setup

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose build

up: setup
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) up -d nginx django

dev: setup
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in dev mode"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) up -d dev worker

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
	@docker compose $(ARGS) exec -T db su - postgres -c "until pg_isready; do sleep 5; done"

frontend-test:
	@docker compose $(ARGS) exec -T dev sh -c "cd /home/web/django_project/frontend && npm install && npm test"

# -----------------------------------------------------------------------------
# ----------------------------------- D E V -----------------------------------
# -----------------------------------------------------------------------------
dev-ci-test: setup
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in DEVELOPMENT mode for CI test"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) up --no-recreate --no-deps -d db worker rabbitmq dev

dev-entrypoint:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running entrypoint.sh in DEVELOPMENT mode"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) exec -T dev "/home/web/django_project/entrypoint.sh"

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
	@docker compose $(ARGS) exec -T dev python manage.py test --keepdb --noinput

# -----------------------------------------------------------------------------
# --------------------------------- U T I L S ---------------------------------
# -----------------------------------------------------------------------------
sleep:
	@sleep 50
	@echo "Done"

# -----------------------------------------------------------------------------
# ---------------------------- P R E - F L I G H T -----------------------------
# -----------------------------------------------------------------------------
setup:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Do setup.sh"
	@echo "------------------------------------------------------------------"
	@./setup.sh

vscode: setup
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Pre-flight: ensuring dev override and env files exist"
	@echo "------------------------------------------------------------------"
	@./vscode.sh