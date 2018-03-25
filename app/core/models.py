from django.db import models
from django.utils import timezone
from django.utils.translation import ugettext_lazy as _


class NewsItem(models.Model):
    """
    Model to store news items to be displayed on the website
    """
    title = models.CharField(max_length=255, verbose_name=_('title'))
    content = models.TextField(verbose_name=_('news item content'))
    published = models.BooleanField(default=False, verbose_name=_('published'))
    published_date = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return str(self.title)

    def save(self, *args, **kwargs):
        if self.published and not self.published_date:
            self.published_date = timezone.now()
        super(NewsItem, self).save()

    class Meta:
        verbose_name = _("news item")
        verbose_name_plural = _("news items")