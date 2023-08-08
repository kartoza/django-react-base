# coding=utf-8

"""Project level settings.

Adjust these values as needed but don't commit passwords etc. to any public
repository!
"""
import os  # noqa

from .contrib import *  # noqa

ALLOWED_HOSTS = ['*']
ADMINS = (
    ('Dimas Ciputra', 'dimas@kartoza.com'),
)
DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'NAME': os.environ.get('DATABASE_NAME', 'django'),
        'USER': os.environ.get('DATABASE_USERNAME', 'docker'),
        'PASSWORD': os.environ.get('DATABASE_PASSWORD', 'docker'),
        'HOST': os.environ.get('DATABASE_HOST', 'db'),
        'PORT': 5432,
        'TEST_NAME': 'unittests',
    }
}

# Set debug to false for production
DEBUG = TEMPLATE_DEBUG = False

# Extra installed apps
INSTALLED_APPS = INSTALLED_APPS + (
    'core',
    'frontend',
)

TEMPLATES[0]['DIRS'] += [
    absolute_path('frontend', 'templates'),
]
