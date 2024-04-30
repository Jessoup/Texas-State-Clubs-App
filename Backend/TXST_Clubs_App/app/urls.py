from django.urls import path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

from . import views
from .views import ClubListView, ClubDetailView
from .views import JoinClubView, LeaveClubView, ListJoinedClubsView

urlpatterns = [
    path("signup/", views.SignUpView.as_view(), name="signup"),
    path("login/", views.LoginView.as_view(), name="login"),
    path("jwt/create/", TokenObtainPairView.as_view(), name="jwt_create"),
    path("jwt/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("jwt/verify/", TokenVerifyView.as_view(), name="token_verify"),
    path('clubs/', ClubListView.as_view(), name='club-list'),
    path('clubs/<int:pk>/', ClubDetailView.as_view(), name='club-detail'),
    path('join-club/<int:clubID>/', JoinClubView.as_view(), name='join-club'),
    path('leave-club/<int:clubID>/', LeaveClubView.as_view(), name='leave-club'),
    path('my-clubs/', ListJoinedClubsView.as_view(), name='my-clubs'),
]