from django.test import TestCase

from .models import NewsItem


class NewsItemTestCase(TestCase):
    def setUp(self):
        NewsItem.objects.create(id=1, title="Django is awesome", content="Lot's of cool statements", published=True)
        NewsItem.objects.create(id=2, title="Docker is also awesome", content="a 100 reasons why", published=False)

    def test_published_gets_date(self):
        """"""
        django_item = NewsItem.objects.get(id=1)
        docker_item = NewsItem.objects.get(id=2)

        self.assertIsNotNone(django_item.published_date)
        self.assertIsNone(docker_item.published_date)
