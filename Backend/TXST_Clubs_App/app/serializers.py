from rest_framework import serializers
from rest_framework.authtoken.models import Token
from rest_framework.validators import ValidationError

from .models import User
from .models import Club
from .models import UserClubRelation

class ClubSerializer(serializers.ModelSerializer):
    class Meta:
        model = Club
        fields = ['id', 'clubName', 'clubDescription']

class CreateClubSerializer(serializers.ModelSerializer):
    class Meta:
        model = Club
        fields = ['clubName', 'clubDescription']

    def create(self, validated_data):
        return Club.objects.create(**validated_data)

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
    class Meta:
        model = UserClubRelation
        fields = ['userID', 'clubID', 'isMember', 'isManager']
        extra_kwargs = {
            'userID': {'read_only': True},
            'clubID': {'read_only': True}
        }

class JoinedClubsSerializer(serializers.ModelSerializer):
    clubName = serializers.ReadOnlyField(source='clubID.clubName')
    clubDescription = serializers.ReadOnlyField(source='clubID.clubDescription')

    class Meta:
        model = UserClubRelation
        fields = ['clubID', 'clubName', 'clubDescription']
