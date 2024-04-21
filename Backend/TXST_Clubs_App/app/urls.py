from django.urls import path, include
from . import views


urlpatterns = [
    path('', views.getRoutes),
    path('users/', views.getUsers),
    path('users/login/', views.loginUser),

    #path('token/', TokenObtainPairView.as_view(), name="get_token"),
    #path('token/refresh/', TokenRefreshView.as_view(), name='refresh_token'),
    path('api-auth/', include('rest_framework.urls')),

    path('users/<str:pk>/update/', views.updateUser),
    path('users/<str:pk>/delete/', views.deleteUser),
    path('users/<str:pk>/', views.getUser),
]