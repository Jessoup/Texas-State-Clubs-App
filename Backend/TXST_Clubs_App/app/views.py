from django.contrib.auth import authenticate
from django.shortcuts import render
from rest_framework import generics, status
from rest_framework.request import Request
from rest_framework.response import Response
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import ValidationError
from rest_framework.permissions import IsAuthenticated
from rest_framework.exceptions import PermissionDenied
from django_filters.rest_framework import DjangoFilterBackend
from .serializers import SignUpSerializer
from .tokens import create_jwt_pair_for_user

from .models import UserClubRelation, Club
from .serializers import UserClubRelationSerializer, JoinedClubsSerializer
# Create your views here.
from .serializers import ClubSerializer, CreateClubSerializer
from .models import Event, EventAttendance
from .serializers import EventSerializer, EventAttendanceSerializer,EventDetailSerializer

class EventCreateView(generics.CreateAPIView):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    permission_classes = [IsAuthenticated]  # Ensuring only authenticated users can create events
class DeleteEventView(generics.DestroyAPIView):
    queryset = Event.objects.all()
    permission_classes = [IsAuthenticated]

    def get_object(self):
        event_id = self.kwargs.get('event_id')
        event = get_object_or_404(Event, pk=event_id)
        return event

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response({"message": "Successfully deleted the event."}, status=status.HTTP_204_NO_CONTENT)

class UserEventsView(generics.ListAPIView):
    serializer_class = EventDetailSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        # Get all event IDs where the user is marked as attending
        attending_events_ids = EventAttendance.objects.filter(
            userID=user, attending=True
        ).values_list('eventID', flat=True)
        # Filter events by those IDs
        return Event.objects.filter(id__in=attending_events_ids).distinct()
class EventListView(generics.ListAPIView):
    queryset = Event.objects.all()
    serializer_class = EventSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['club', 'timeStart', 'timeEnd']

    def get_queryset(self):
        user_clubs = UserClubRelation.objects.filter(userID=self.request.user, isMember=True).values_list('clubID', flat=True)
        return super().get_queryset().filter(club__id__in=user_clubs)

class AttendEventView(generics.CreateAPIView):
    queryset = EventAttendance.objects.all()
    serializer_class = EventAttendanceSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        event_id = self.kwargs['event_id']  # Getting event_id from the URL parameters
        event = get_object_or_404(Event, pk=event_id)

        # Check if the user is part of the club hosting the event
        if not UserClubRelation.objects.filter(userID=self.request.user, clubID=event.club, isMember=True).exists():
            raise PermissionDenied({"message": "You are not a member of the club hosting this event."})

        # Save the attendance with the user and event details
        serializer.save(userID=self.request.user, eventID=event, attending=True)
class EventAttendeesView(generics.ListAPIView):
    serializer_class = EventAttendanceSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        event_id = self.kwargs.get('event_id')
        return EventAttendance.objects.filter(eventID=event_id, attending=True)

class UnattendEventView(generics.UpdateAPIView):
    queryset = EventAttendance.objects.all()
    serializer_class = EventAttendanceSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        event_id = self.kwargs.get('event_id')
        user = self.request.user
        # Get the attendance object that corresponds to this user and event
        attendance = get_object_or_404(EventAttendance, eventID=event_id, userID=user, attending=True)
        return attendance

    def perform_update(self, serializer):
        # Update the event attendance to mark as not attending
        serializer.save(attending=False)
                        
class ClubListView(generics.GenericAPIView):
    serializer_class = CreateClubSerializer
    permission_classes = [] 

    def get(self, request):
        clubs = Club.objects.all().order_by('id')  # Order queryset by id or any other field
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


class ClubEventsDetailView(generics.ListAPIView):
    serializer_class = EventDetailSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        # Retrieve clubID from the URL and filter events accordingly
        clubID = self.kwargs['clubID']
        return Event.objects.filter(club__id=clubID)

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
    serializer_class = UserClubRelationSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        club_id = self.kwargs.get('clubID')
        club = get_object_or_404(Club, pk=club_id)
        serializer.save(userID=self.request.user, clubID=club, isMember=True, isManager=False)
class LeaveClubView(generics.DestroyAPIView):
    queryset = UserClubRelation.objects.all()
    serializer_class = UserClubRelationSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        club_id = self.kwargs.get('clubID')
        obj = get_object_or_404(UserClubRelation, userID=self.request.user, clubID=club_id, isMember=True)
        return obj

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        self.perform_destroy(instance)
        return Response({"message": "Successfully left the club."}, status=status.HTTP_204_NO_CONTENT)

class ListJoinedClubsView(generics.ListAPIView):
    serializer_class = JoinedClubsSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return UserClubRelation.objects.filter(userID=self.request.user, isMember=True)
