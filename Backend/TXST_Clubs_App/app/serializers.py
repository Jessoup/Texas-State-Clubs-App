from rest_framework import serializers
from rest_framework.authtoken.models import Token
from rest_framework.validators import ValidationError

from .models import User
from .models import Club
from .models import UserClubRelation
from .models import Event, EventAttendance

class ClubSerializer(serializers.ModelSerializer):
    clubID = serializers.IntegerField(source='id', read_only=True)  # Continue using clubID

    class Meta:
        model = Club
        fields = ['clubID', 'clubName', 'clubDescription']

class CreateClubSerializer(serializers.ModelSerializer):
    class Meta:
        model = Club
        fields = ['clubName', 'clubDescription']

    def create(self, validated_data):
        return Club.objects.create(**validated_data)

class EventSerializer(serializers.ModelSerializer):
    clubID = serializers.IntegerField(write_only=True)  # Accept clubID as input but do not include in serialized output

    class Meta:
        model = Event
        fields = ['id', 'eventName', 'timeStart', 'timeEnd', 'location', 'clubID']

    def validate_clubID(self, value):
        # Validate that the provided clubID corresponds to an existing Club
        if not Club.objects.filter(id=value).exists():
            raise serializers.ValidationError("This club does not exist.")
        return value

    def create(self, validated_data):
        # Extract clubID and find the Club instance
        clubID = validated_data.pop('clubID')
        club = Club.objects.get(id=clubID)
        # Create Event instance with the Club
        event = Event.objects.create(**validated_data, club=club)
        return event
class EventDetailSerializer(serializers.ModelSerializer):
    attendees = serializers.SerializerMethodField()

    class Meta:
        model = Event
        fields = ['id', 'eventName', 'timeStart', 'timeEnd', 'location', 'attendees']

    def get_attendees(self, obj):
        attendees = EventAttendance.objects.filter(eventID=obj, attending=True).select_related('userID')
        return [{'email': attendee.userID.email} for attendee in attendees]

class EventAttendanceSerializer(serializers.ModelSerializer):
    userID = serializers.StringRelatedField(source='userID.email', read_only=True)  # Ensure userID is read-only
    eventID = serializers.IntegerField(write_only=True, required=False)  # Set eventID as write-only and not required if it is fetched from URL

    class Meta:
        model = EventAttendance
        fields = ['id', 'userID', 'eventID', 'attending']

    def validate_eventID(self, value):
        # Ensure the event exists
        if not Event.objects.filter(id=value).exists():
            raise serializers.ValidationError("This event does not exist.")
        return value

class SignUpSerializer(serializers.ModelSerializer):
    email = serializers.CharField(max_length=80)
    first_name = serializers.CharField(max_length=40)
    last_name = serializers.CharField(max_length=40)
    password = serializers.CharField(min_length=8, write_only=True)

    class Meta:
        model = User
        fields = ["email", "first_name", "last_name", "password"]

    def validate(self, attrs):
        email_exists = User.objects.filter(email=attrs["email"]).exists()
        if email_exists:
            raise ValidationError("Email is already in use")
        return super().validate(attrs)

    def create(self, validated_data):
        password = validated_data.pop("password")
        user = super().create(validated_data)
        user.set_password(password)
        user.save()
        Token.objects.create(user=user)
        return user

class UserClubRelationSerializer(serializers.ModelSerializer):
    clubID = serializers.IntegerField(source='clubID.id', read_only=True)  # Use clubID here too

    class Meta:
        model = UserClubRelation
        fields = ['userID', 'clubID', 'isMember', 'isManager']
        read_only_fields = ['userID', 'clubID', 'isMember', 'isManager']

class JoinedClubsSerializer(serializers.ModelSerializer):
    clubID = serializers.IntegerField(source='clubID.id', read_only=True)
    clubName = serializers.ReadOnlyField(source='clubID.clubName')
    clubDescription = serializers.ReadOnlyField(source='clubID.clubDescription')

    class Meta:
        model = UserClubRelation
        fields = ['clubID', 'clubName', 'clubDescription']