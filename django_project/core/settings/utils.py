# -*- coding: utf-8 -*-
"""Utilities for project."""
import os

# Absolute filesystem path to the Django project directory:
DJANGO_ROOT = os.path.dirname(
    os.path.dirname(
        os.path.dirname(os.path.abspath(__file__))
    ))


def absolute_path(*args):
    """
    Return the absolute path inside the Django project.

    Parameters
    ----------
    *args : str
        Path components to join with the Django project root.

    Returns
    -------
    str
        The absolute path inside the Django project.
    """
    return os.path.join(DJANGO_ROOT, *args)


def ensure_secret_key_file():
    """
    Ensure that ``secret.py`` exists in the Django settings directory.

    If the file does not exist, it will be created and populated with a
    randomly generated ``SECRET_KEY`` suitable for Django settings.
    """
    secret_path = absolute_path('core', 'settings', 'secret.py')
    if not os.path.exists(secret_path):
        from django.utils.crypto import get_random_string
        secret_key = get_random_string(
            50, 'abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)')
        with open(secret_path, 'w') as f:
            f.write("SECRET_KEY = " + repr(secret_key) + "\n")


# Import the secret key
ensure_secret_key_file()
