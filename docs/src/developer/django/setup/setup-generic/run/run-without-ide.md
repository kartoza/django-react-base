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

# Run without IDE

If you're using a text editor other than an IDE (such as PyCharm, Sublime Text, or Vim), you can run the application manually from the terminal:

1. Navigate to the root directory of the project.
2. Open a terminal and execute the following command:

```
make dev
```

Note: With this approach, you won’t have access to integrated debugging features provided by full IDEs.

To verify that the development instance is running correctly, execute the following command:
```bash
docker logs -f django_react_base-dev-1
```
Allow the process to continue until the following message or indicator appears:

![image.png](../img/building-1.png)

Once this confirmation is visible, you may proceed to the next step to access your running instance.

## Viewing your test instance

After completing the steps above, you should have the development server available on port 2000 of your local host:

```
http://localhost:8000
```

![image.png](../img/building-2.png)

By Default, we can use the admin credential:
```
username : admin
password : admin
```

> 🪧 Now that the application is set up, you may begin making updates.