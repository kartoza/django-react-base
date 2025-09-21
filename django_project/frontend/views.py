from django.views.generic import TemplateView, View
from django.http import HttpResponse
from django.utils.decorators import method_decorator
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
import json
import requests
from urllib.parse import urlparse


class FrontendView(TemplateView):
    template_name = "app.html"


@method_decorator(csrf_exempt, name="dispatch")
class SentryProxyView(View):
    sentry_key = settings.SENTRY_DSN

    def post(self, request):
        """Sentry proxy post method"""
        host = "sentry.io"

        envelope = request.body.decode("utf-8")
        pieces = envelope.split("\n", 1)
        header = json.loads(pieces[0])

        if "dsn" in header:
            dsn = urlparse(header["dsn"])
            project_id = int(dsn.path.strip("/"))

            sentry_url = f"https://{host}/api/{project_id}/envelope/"
            headers = {
                "Content-Type": "application/x-sentry-envelope",
            }
            response = requests.post(
                sentry_url, headers=headers, data=envelope.encode("utf-8"), timeout=200
            )

            return HttpResponse(response.content, status=response.status_code)

        return HttpResponse(status=400)
