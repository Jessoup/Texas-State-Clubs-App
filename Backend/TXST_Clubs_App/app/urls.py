from django.urls import path
from .views import getRoutes, getUsers, getUser, createUser, updateUser, deleteUser, login_view

urlpatterns = [
    path('api/routes/', getRoutes, name='routes'),
    path('api/users/', getUsers, name='users'),
    path('api/users/create/', createUser, name='create-user'),
    path('api/users/<str:pk>/update/', updateUser, name='update-user'),
    path('api/users/<str:pk>/delete/', deleteUser, name='delete-user'),
    path('api/users/<str:pk>/', getUser, name='get-user'),
    path('api/login/', login_view, name='login'), 
]