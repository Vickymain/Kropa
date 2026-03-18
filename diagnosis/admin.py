"""
KROPA – Django Admin registration.
Allows query history browsing via /admin/.
"""
from django.contrib import admin
from .models import QueryHistory


@admin.register(QueryHistory)
class QueryHistoryAdmin(admin.ModelAdmin):
    list_display  = ('crop_name', 'top_disease', 'confidence', 'created_at')
    list_filter   = ('crop_name', 'confidence')
    search_fields = ('crop_name', 'top_disease')
    readonly_fields = ('created_at',)
