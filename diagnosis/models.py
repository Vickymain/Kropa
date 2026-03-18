"""
KROPA – Django Models
=====================
Stores user query history for optional analytics/review.
The diagnosis logic itself lives entirely in Prolog; these models
only record what the user asked and what Prolog returned.
"""

from django.db import models
import json


class QueryHistory(models.Model):
    """Records a single completed diagnosis session."""
    crop_id        = models.CharField(max_length=50)
    crop_name      = models.CharField(max_length=100)
    symptoms       = models.TextField()           # JSON list of symptom ids
    top_disease    = models.CharField(max_length=200, blank=True)
    confidence     = models.CharField(max_length=20, blank=True)
    results_json   = models.TextField(blank=True) # full JSON result list
    created_at     = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']
        verbose_name = 'Query History'
        verbose_name_plural = 'Query Histories'

    def get_symptoms_list(self):
        try:
            return json.loads(self.symptoms)
        except Exception:
            return []

    def get_results(self):
        try:
            return json.loads(self.results_json)
        except Exception:
            return []

    def __str__(self):
        return f"{self.crop_name} – {self.top_disease} ({self.created_at:%Y-%m-%d %H:%M})"
