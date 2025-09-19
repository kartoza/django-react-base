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

# Removing your development environment

If you want to completely remove the development environment you should do the following:

* 🚩🚩🚩
* 🚩🚩🚩
* **WARNING:** The commands listed here are destructive and may result in loss of work if you do not have backups!
* 🚩🚩🚩
* 🚩🚩🚩

## Remove the code tree

To remove the code tree entirely:

```
rm -rf django-react-base/
```

## Removing docker containers

To list all django_react_base docker containers:

```
docker ps -a | grep django_react_base
```

Example output:

```
ca145b57a7f7   kartoza/django_react_base:dev   "/usr/sbin/sshd -D"      45 seconds ago   Up 32 seconds             0.0.0.0:8001->22/tcp, [::]:8001->22/tcp, 0.0.0.0:8000->8080/tcp, [::]:8000->8080/tcp   django_react_base-dev-1
2787af751713   kartoza/django_react_base:dev   "celery -A core work…"   45 seconds ago   Up 44 seconds             22/tcp, 8080/tcp                                                                       django_react_base-worker-1
b3c750fd3dd4   kartoza/postgis:17-3.5          "/bin/bash /scripts/…"   45 seconds ago   Up 44 seconds             5432/tcp                                                                               django_react_base-db-1
b9c611b040b1   kartoza/django_react_base:dev   "sh -c 'npm install …"   45 seconds ago   Up 44 seconds (healthy)   22/tcp, 8080/tcp, 0.0.0.0:9000->9000/tcp, [::]:9000->9000/tcp                          django_react_base-webpack-1
40f85b703342   bitnamilegacy/redis:8.2.1       "/opt/bitnami/script…"   45 seconds ago   Up 44 seconds             6379/tcp                                                                               django_react_base-redis-1
```

List only the ID's of django_react_base docker containers:

```
docker ps -a | grep django_react_base | awk '{print $1}'
```

Example output:

```
ca145b57a7f7
2787af751713
b3c750fd3dd4
b9c611b040b1
40f85b703342
```

To kill all django_react_base docker containers:

```
docker kill $(docker ps -a | grep django_react_base | awk '{print $1}')
```

Example output:

```
ca145b57a7f7
2787af751713
b3c750fd3dd4
b9c611b040b1
40f85b703342
```

To remove all django_react_base docker containers:

```
docker rm $(docker ps -a | grep django_react_base | awk '{print $1}')
```

Example output:

```
ca145b57a7f7
2787af751713
b3c750fd3dd4
b9c611b040b1
40f85b703342
```

Verification that everything is removed:

```
docker ps -a | grep django_react_base
```

Example output:

```
```
