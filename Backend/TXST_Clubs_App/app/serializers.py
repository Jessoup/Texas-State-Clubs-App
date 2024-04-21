from rest_framework.serializers import ModelSerializer
from .models import CustomUser
from django.contrib.auth.hashers import make_password
#from django.contrib.auth.models import User

class UserSerializer(ModelSerializer):
    class Meta:
        model = CustomUser
        fields = '__all__'
