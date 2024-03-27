from django.urls import path
from .views import ListClub, DetailClub

urlpatterns = [
    path('',ListClub.as_view()),
    path('<int:pk>/', DetailClub.as_view())
]