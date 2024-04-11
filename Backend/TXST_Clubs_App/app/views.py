from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserSerializer
from .models import User
# Create your views here.

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
    
    user = User.objects.create(
        firstName=data['firstName'],
        lastName=data['lastName'],
        userName=data['userName'],
        password=data['password'],
        isAdmin=data['isAdmin'],
    )

    
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)


@api_view(['PUT'])
def updateUser(request, pk):
    data = request.data

    user = User.objects.get(id=pk)
    serializer = UserSerializer(user, data=request.data)
    if serializer.is_valid():
        serializer.save()
    
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteUser(request, pk):
    user = User.objects.get(id=pk)
    user.delete()
    return Response('User was deleted.')