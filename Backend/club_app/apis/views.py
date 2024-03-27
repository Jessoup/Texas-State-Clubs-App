from django.shortcuts import render

# Create your views here.
from club import models
from rest_framework import generics
from .serializers import ClubSerializer

class ListClub(generics.ListCreateAPIView):
    queryset = models.Club.objects.all()
    serializer_class = ClubSerializer

class DetailClub(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Club.objects.all()
    serializer_class = ClubSerializer