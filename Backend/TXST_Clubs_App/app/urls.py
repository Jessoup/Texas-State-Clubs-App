from django.urls import path
from .views import getRoutes, getUsers, getUser, createUser, updateUser, deleteUser, login_view

urlpatterns = [
    path('routes/', getRoutes, name='routes'),
    path('users/', getUsers, name='users'),
    path('users/create/', createUser, name='create-user'),
    path('users/<str:pk>/update/', updateUser, name='update-user'),
    path('users/<str:pk>/delete/', deleteUser, name='delete-user'),
    path('users/<str:pk>/', getUser, name='get-user'),
    path('login/', login_view, name='login'), 
]