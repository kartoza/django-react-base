export COMPOSE_FILE=deployment/docker-compose.yml:deployment/docker-compose.override.yml
SHELL := /bin/bash

# Paths for dev override/template
OVERRIDE_PATH := deployment/docker-compose.override.yml
OVERRIDE_TEMPLATE_PATH := deployment/docker-compose.override.template.yml

ENV_PATH := deployment/.env
ENV_TEMPLATE_PATH := deployment/.template.env

.PHONY: build up dev down flake wait-db frontend-test dev-ci-test dev-entrypoint dev-initialize dev-runserver dev-test sleep ensure-dev-files

build:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose build

up: ensure-dev-files
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Running in production mode"
	@echo "------------------------------------------------------------------"
	@docker compose $(ARGS) up -d nginx django

dev: ensure-dev-files
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
dev-ci-test: ensure-dev-files
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
ensure-dev-files:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Pre-flight: ensuring dev override and env files exist"
	@echo "------------------------------------------------------------------"
	@# Ensure deployment/docker-compose.override.yml
	@if [ ! -f "$(OVERRIDE_PATH)" ]; then \
		if [ -f "$(OVERRIDE_TEMPLATE_PATH)" ]; then \
			cp "$(OVERRIDE_TEMPLATE_PATH)" "$(OVERRIDE_PATH)"; \
			echo "Created $(OVERRIDE_PATH) from $(OVERRIDE_TEMPLATE_PATH)."; \
		else \
			echo "$(OVERRIDE_PATH) not found AND no template at $(OVERRIDE_TEMPLATE_PATH)."; \
		fi; \
	else \
		echo "$(OVERRIDE_PATH) already exists; leaving it untouched."; \
	fi
	@# Ensure .env from .template.env
	@if [ ! -f "$(ENV_PATH)" ]; then \
		if [ -f "$(ENV_TEMPLATE_PATH)" ]; then \
			cp "$(ENV_TEMPLATE_PATH)" "$(ENV_PATH)"; \
			echo "Created .env from .template.env."; \
		else \
			echo ".env not found AND no .template.env present."; \
		fi; \
	else \
		echo ".env already exists; leaving it untouched."; \
	fi
