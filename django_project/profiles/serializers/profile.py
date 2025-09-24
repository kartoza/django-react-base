"""Serializers for profile endpoints."""

from django.contrib.auth import get_user_model
from rest_framework import serializers

User = get_user_model()


class ProfileSerializer(serializers.ModelSerializer):
    """Serializer exposing public fields of the authenticated user."""

    class Meta:
        """Configuration for ProfileSerializer."""

        model = User
        fields = ("id", "username", "first_name", "last_name", "email")
