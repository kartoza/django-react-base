---
title: Django React Base
summary: PROJECT_SUMMARY
  - PERSON_1
  - PERSON_2
date: DATE
some_url: PROJECT_GITHUB_URL
copyright: Copyright 2023, PROJECT_OWNER
contact: PROJECT_CONTACT
license: This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
---

## Configuration

In this step, you'll update some files to get the project working — but don’t worry, most of it is automated! All you need to do is:

1. Navigate to the root of the project.
2. Run the setup script:

```bash
./setup.sh
```

> 🪧 Now that the codebase is set up, you’re ready to run the application. Continue to the [run guide](run/index.md).

You may also want to review how to set up other environments (see below) before running the project.

### Set up different environment (optional)

To edit the application settings (e.g. username of admin user, password of admin user, port of server etc.), use a text editor to edit **deployment/.env**. See the descriptions below for each of variable.

```bash
COMPOSE_PROJECT_NAME=django_react_base
DJANGO_SETTINGS_MODULE=core.settings.dev
DJANGO_TAG=0.0.1
HTTP_PORT=80

ADMIN_USERNAME=admin
ADMIN_PASSWORD=admin
ADMIN_EMAIL=admin@example.com

DATABASE_NAME=django
DATABASE_USERNAME=docker
DATABASE_PASSWORD=docker
DATABASE_HOST=db

REDIS_HOST=redis
REDIS_PASSWORD=redis_password

RABBITMQ_HOST=rabbitmq
SENTRY_DSN=
```

> 🪧 Now that the codebase is set up, you’re ready to run the application. Continue to the [run guide](run/index.md).
