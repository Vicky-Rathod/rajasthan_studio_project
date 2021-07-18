from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from .views import CoachView,ThirtyMinView
urlpatterns = [
    path('coach-list/', CoachView.as_view()),
    path('coach/', ThirtyMinView.as_view()),
    ]

urlpatterns = format_suffix_patterns(urlpatterns)



