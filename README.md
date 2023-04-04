# 🚀 Kartoza Django React

A boilerplate for kickstarting Kartoza Django backend and React frontend projects

## 🌟 Features
- Django backend with Django Rest Framework (DRF) for API development
- React frontend with Redux for state management
- Webpack configurations for modern JavaScript (ES6+) support
- Responsive design with [MUI](https://mui.com/)
- Docker and docker-compose support for containerization
- Code linting with ESLint and Prettier (frontend) and flake8 (backend)

## ⚡ Quick Start


- Clone the repository
```
git clone https://github.com/kartoza/django-react-base.git
cd django-react-base
```

- Copy and customize the environment file and the Docker Compose override file from the template.
```
cp deployment/.template.env deployment/.env
cp deployment/docker-compose.override.template.yml deployment/docker-compose.override.yml
```

- Build the project using the provided command in makefile
```
make build
```

- Run the application using Docker and the provided makefile
```
make run
```


## 📚 Documentation
For detailed setup instructions, custom configurations, deployment, and additional features, please refer to the wiki.

## 🤝 Contributing
Contributions are welcome! Please read our contributing guide to learn how you can get involved and help improve this project.

## 📄 License
This project is licensed under the MIT License. See the LICENSE file for details.
