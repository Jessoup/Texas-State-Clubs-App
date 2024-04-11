from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer

# Define your views here.

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
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getUser(request, pk):
    user = User.objects.get(id=pk)
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createUser(request):
    data = request.data
    
    # Create user with the existing data structure, assuming plain text password storage
    user = User.objects.create(
        first_name=data['firstName'],
        last_name=data['lastName'],
        username=data['userName'],
        password=data['password'],  # Note: Plain text password (Not recommended)
        is_staff=data.get('isAdmin', False)
    )
    user.save()
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updateUser(request, pk):
    user = User.objects.get(id=pk)
    serializer = UserSerializer(user, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    else:
        return Response(serializer.errors, status=400)  # Include error responses

@api_view(['DELETE'])
def deleteUser(request, pk):
    user = User.objects.get(id=pk)
    user.delete()
    return Response('User was deleted.')

@api_view(['POST'])
def login_view(request):
    username = request.data.get('username')
    password = request.data.get('password')
    print(f"Attempting to log in with username: {username} and password: {password}")
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        print(f"User {username} logged in successfully.")
        return Response({"message": "User logged in successfully"})
    else:
        print(f"Login failed for user {username}.")
        return Response({"error": "Invalid credentials"}, status=400)
