# coding=utf-8

from .prod import *  # noqa

DEBUG = True
IS_TEST = True

# Disable caching while in development
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}
