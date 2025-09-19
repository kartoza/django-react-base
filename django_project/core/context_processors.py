"""Context processors."""
from django.conf import settings
from django.http import HttpRequest


def sentry_dsn(request: HttpRequest) -> dict[str, str]:
    """Inject Sentry DSN into the template context.

    Args:
        request: Incoming HTTP request (unused).

    Returns:
        dict[str, str]: Mapping with the ``"SENTRY_DSN"`` key.
    """
    return {"SENTRY_DSN": settings.SENTRY_DSN}
