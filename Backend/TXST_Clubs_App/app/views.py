from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer
from .models import CustomUser
#from rest_framework import generics
#from django.contrib.auth.models import User
#from rest_framework.permissions import IsAuthenticated, AllowAny
# Create your views here.

'''
class UserClubRelationListCreate(generics.ListCreateAPIView):
    serializer_class = UserClubRelationSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return UserClubRelation.objects.filter(userID=user)

    def perform_create(self, serializer):
        if serializer.is_valid():
            serializer.save(userID=self.request.user)
        else:
            print(serializer.errors)

class UserClubRelationDelete(generics.DestroyAPIView):
    serializer_class = UserClubRelationSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        user = self.request.user
        return UserClubRelation.objects.filter(userID=user)

class CreateUserView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [AllowAny]

'''

@api_view(['GET'])
def getRoutes(request):
    routes = [
        {
            'Endpoint': '/users/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of users'
        }
    ]
    return Response(routes)

@api_view(['GET'])
def getUsers(request):
    users = CustomUser.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getUser(request, pk):
    user = CustomUser.objects.get(id=pk)
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updateUser(request, pk):
    data = request.data

    user = CustomUser.objects.get(id=pk)
    serializer = UserSerializer(user, data=request.data)
    if serializer.is_valid():
        serializer.save()
    
    return Response(serializer.data)

@api_view(['POST'])
def createUser(request):
    data = request.data
    
    # Create user with the existing data structure, assuming plain text password storage
    user = CustomUser.objects.create(
        first_name=data['firstName'],
        last_name=data['lastName'],
        username=data['userName'],
        email=data['email'],
        password=data['password'],  # Note: Plain text password (Not recommended)
        isAdmin=data.get('isAdmin', False)
    )
    user.save()
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteUser(request, pk):
    user = CustomUser.objects.get(id=pk)
    user.delete()
    return Response('User was deleted.')

@api_view(['POST'])
def loginUser(request):
    form = forms.LoginForm(request.POST)
    if form.is_valid():
        username = request.data.get('userName')
        password = request.data.get('password')

        print(f"Attempting to log in with username: {username} and password: {password}")
        user = authenticate(request, userName=username, password=password)
    if user is not None:
        login(request, user)
        print(f"User {username} logged in successfully.")
        return Response({"message": "User logged in successfully"})
    else:
        print(f"Login failed for user {username}.")
        return Response({"error": "Invalid credentials"}, status=400)
    