from celery import shared_task
from django.contrib.auth import get_user_model

User = get_user_model()


@shared_task(bind=True, autoretry_for=(User.DoesNotExist,), retry_backoff=True, max_retries=1)
def normalize_username(self, user_id: int) -> dict:
    """Normalize a user's first and last name."""
    user = User.objects.get(pk=user_id)

    new_first = (user.first_name or "").strip().title()
    new_last = (user.last_name or "").strip().title()

    changed = (new_first != user.first_name) or (new_last != user.last_name)
    if changed:
        user.first_name = new_first
        user.last_name = new_last
        user.save(update_fields=["first_name", "last_name"])

    return {
        "user_id": user.id,
        "changed": changed,
        "first_name": user.first_name,
        "last_name": user.last_name,
    }
