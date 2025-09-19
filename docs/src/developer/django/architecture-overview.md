---
title: Django Application
summary: PROJECT_SUMMARY
    - PERSON_1
    - PERSON_2
date: DATE
some_url: PROJECT_GITHUB_URL
copyright: Copyright 2023, PROJECT_OWNER
contact: PROJECT_CONTACT
license: This program is free software; you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
---

Django React Base is built on a modern web stack template that leverages the power of Django, PostgreSQL, and Cloud Native GIS (vector tiles, COGS) for geospatial capabilities. The architecture is designed to be modular, scalable, and maintainable, allowing for easy integration of new features and data sources.

### Key Components

- **Django**: The web framework that powers the application, providing a robust backend for handling requests, managing data, and serving the frontend.
- **PostgreSQL**: The relational database that stores all application data, including user information, geospatial data, and application settings.
- **GeoDjango**: An extension of Django that adds support for geographic data, enabling advanced geospatial queries and operations.
- **Docker**: Used for containerization, allowing the application to run consistently across different environments.
- **Celery**: A distributed task queue that handles background tasks, such as data processing and notifications, ensuring the application remains responsive.
- **Redis**: Serves as the message broker and cache layer that powers Celery and improves app performance.
- **React**: A JavaScript library for building interactive user interfaces and single-page applications (SPAs).
- **Chakara**: A React-based component library that provides accessible, responsive, and themeable UI components out of the box.
- **MapLibre GL JS**: An open-source mapping library for rendering interactive maps on the frontend.

### Architecture Diagram

To be populated