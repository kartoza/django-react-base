from django.urls import path

from profiles.views.profile import ProfileView

urlpatterns = [path("me/", ProfileView.as_view(), name="me")]
