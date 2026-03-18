"""KROPA – URL patterns (chat-only)."""
from django.urls import path
from . import views

urlpatterns = [
    path('',              views.chat,          name='home'),
    path('diagnose/',     views.diagnose_text, name='diagnose_text'),
]
