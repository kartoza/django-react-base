from rest_framework.permissions import IsAuthenticated
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView

from profiles.serializers.profile import ProfileSerializer


class ProfileView(APIView):
    """Return the authenticated user's profile data."""

    permission_classes = [IsAuthenticated]

    def get(self, request: Request) -> Response:
        """Retrieve the current user's profile."""
        serializer = ProfileSerializer(request.user)
        return Response(serializer.data)
