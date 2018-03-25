from django.contrib import admin

from .models import *


@admin.register(NewsItem)
class NewsItemAdmin(admin.ModelAdmin):
    list_display = (
        "id", "title", "published")
    search_fields = ("title",)
    list_filter = ("published",)