from django.contrib.auth import authenticate
from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import ValidationError
from rest_framework.permissions import IsAuthenticated

from .serializers import SignUpSerializer
from .tokens import create_jwt_pair_for_user

from .models import UserClubRelation, Club
from .serializers import UserClubRelationSerializer, JoinedClubsSerializer
# Create your views here.
from .serializers import ClubSerializer, CreateClubSerializer
from .models import Club

class ClubListView(generics.GenericAPIView):
    serializer_class = CreateClubSerializer
    permission_classes = [] 
    def get(self, request):
        clubs = Club.objects.all()
        serializer = ClubSerializer(clubs, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = self.serializer_class(data=request.data)
        if serializer.is_valid():
            club = serializer.save()
            return Response(ClubSerializer(club).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ClubDetailView(generics.GenericAPIView):
    serializer_class = ClubSerializer

    def get(self, request, pk):
        club = get_object_or_404(Club, pk=pk)
        serializer = self.serializer_class(club)
        return Response(serializer.data, status=status.HTTP_200_OK)

class SignUpView(generics.GenericAPIView):
    serializer_class = SignUpSerializer
    permission_classes = []

    def post(self, request: Request):
        data = request.data

        serializer = self.serializer_class(data=data)

        if serializer.is_valid():
            serializer.save()

            response = {"message": "User Created Successfully", "data": serializer.data}

            return Response(data=response, status=status.HTTP_201_CREATED)

        elif isinstance(serializer.errors.get("email"), ValidationError) and "Email is already in use" in serializer.errors.get("email").messages:
            return Response(data={"message": "Email is already in use"}, status=status.HTTP_400_BAD_REQUEST)

        return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class LoginView(APIView):
    permission_classes = []

    def post(self, request: Request):
        email = request.data.get("email")
        password = request.data.get("password")

        user = authenticate(email=email, password=password)

        if user is not None:

            tokens = create_jwt_pair_for_user(user)

            response = {"message": "Login Successfull", "tokens": tokens}
            return Response(data=response, status=status.HTTP_200_OK)

        else:
            return Response(data={"message": "Invalid email or password"})

    def get(self, request: Request):
        content = {"user": str(request.user), "auth": str(request.auth)}

        return Response(data=content, status=status.HTTP_200_OK)
    
class JoinClubView(generics.CreateAPIView):
    queryset = UserClubRelation.objects.all()
    serializer_class = UserClubRelationSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        club_id = self.kwargs.get('clubID')
        club = get_object_or_404(Club, pk=club_id)
        serializer.save(userID=self.request.user, clubID=club, isMember=True)

class LeaveClubView(generics.DestroyAPIView):
    queryset = UserClubRelation.objects.all()
    serializer_class = UserClubRelationSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        obj = get_object_or_404(UserClubRelation, userID=self.request.user, clubID=self.kwargs['clubID'], isMember=True)
        return obj

class ListJoinedClubsView(generics.ListAPIView):
    serializer_class = JoinedClubsSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return UserClubRelation.objects.filter(userID=self.request.user, isMember=True)
