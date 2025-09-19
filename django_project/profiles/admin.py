"""Admin customizations for User with normalize-name actions."""

from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin as DjangoUserAdmin
from django.db.models import QuerySet
from django.http import HttpRequest

from profiles.tasks.username import normalize_username

User = get_user_model()


@admin.action(description="Normalize name via Celery")
def normalize_name_action(
    modeladmin: admin.ModelAdmin, request: HttpRequest, queryset: QuerySet[User]
) -> None:
    """Queue Celery tasks to normalize selected users' names.

    Args:
        modeladmin: The admin instance invoking this action.
        request: Current HTTP request.
        queryset: Selected users to process.
    """
    count = 0
    for uid in queryset.values_list("id", flat=True):
        normalize_username.delay(uid)
        count += 1
    modeladmin.message_user(request, f"Queued normalize_username for {count} user(s).")


@admin.action(description="Normalize name now (sync)")
def normalize_name_sync_action(
    modeladmin: admin.ModelAdmin, request: HttpRequest, queryset: QuerySet[User]
) -> None:
    """Synchronously normalize names for selected users.

    Useful in development when the broker/worker is unavailable.

    Args:
        modeladmin: The admin instance invoking this action.
        request: Current HTTP request.
        queryset: Selected users to process.
    """
    count = 0
    changed = 0
    for uid in queryset.values_list("id", flat=True):
        result = normalize_username.run(uid)
        changed += 1 if result.get("changed") else 0
        count += 1
    modeladmin.message_user(
        request, f"Ran sync normalization for {count} user(s); {changed} changed."
    )


class UserAdmin(DjangoUserAdmin):
    """User admin with normalize-name actions."""
    actions = [normalize_name_action, normalize_name_sync_action]


admin.site.unregister(User)
admin.site.register(User, UserAdmin)
