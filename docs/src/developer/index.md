---
title: For Developers
summary: PROJECT_SUMMARY
    - PERSON_1
    - PERSON_2
date: DATE
some_url: PROJECT_GITHUB_URL
copyright: Copyright 2023, PROJECT_OWNER
contact: PROJECT_CONTACT
license: This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
---

# For Developers

The Django React Base Project is a Django project structured into several components.
It includes a Django application, Playwright for end-to-end testing, and project documentation.

Each component serves a different purpose.

### Key Components

- **[Django application](django/architecture-overview.md)**: Contains the main Django codebase, organized into the **deployment** and **django_project** folders.
- **Playwright**: Located in the **playwright** folder. Contains all end-to-end tests for the application and is integrated into the GitHub workflow.
- **Documentation**: Located in the **docs** folder. Contains all project documentation, which is being built in the GitHub workflow.

### Repo Components

![image.png](resources/repo-components.png)

### Repo Diagram

![image.png](resources/repo-overview.png)