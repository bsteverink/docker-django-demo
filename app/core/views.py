from django.shortcuts import render, get_object_or_404

from .models import NewsItem


def index(request):
    """Core index view
    """

    context = {

    }
    return render(request, "core/index.html", context)


def view_news_item(request, pk):
    redirect = request.GET.get('next', '/')

    news_item = get_object_or_404(NewsItem, pk=pk)

    return render(request, 'core/news_item.html', {
        'item': news_item,
        'next': redirect
    })