from django.urls import path
from . import views

urlpatterns = [
    path('', views.getRoutes),
    path('users/', views.getUsers),
    path('users/create/', views.createUser),
    path('users/<str:pk>/update/', views.updateUser),
    path('users/<str:pk>/delete/', views.deleteUser),
    path('users/<str:pk>/', views.getUser),
]