"""Context processors."""
from django.conf import settings


def sentry_dsn(request):
    """
    Return the Sentry DSN setting.

    Parameters
    ----------
    request : django.http.HttpRequest
        The incoming HTTP request (not used in this function).

    Returns
    -------
    dict
        Dictionary containing the Sentry DSN with key ``"SENTRY_DSN"``.
    """
    return {
        'SENTRY_DSN': settings.SENTRY_DSN
    }
