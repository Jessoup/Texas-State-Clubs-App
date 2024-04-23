from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.


class CustomUserManager(BaseUserManager):
    def create_user(self, email, first_name, last_name, password, **extra_fields):
        email = self.normalize_email(email)

        user = self.model(email=email, first_name=first_name, last_name=last_name, **extra_fields)

        user.set_password(password)

        user.save()

        return user

    def create_superuser(self, email, first_name, last_name, password, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser has to have is_staff being True")

        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser has to have is_superuser being True")

        return self.create_user(email=email, first_name=first_name, last_name=last_name, password=password, **extra_fields)


class User(AbstractUser):
    email = models.CharField(max_length=80, unique=True)
    first_name = models.CharField(max_length=40)
    last_name = models.CharField(max_length=40)
    username = models.CharField(max_length=45)
    date_of_birth = models.DateField(null=True)

    objects = CustomUserManager()
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["first_name", "last_name"]

    def __str__(self):
        return self.email

class Club(models.Model):
    clubName = models.CharField(max_length=80)
    clubDescription = models.TextField(max_length=200)

class UserClubRelation(models.Model):
    userID = models.ForeignKey(User, on_delete=models.CASCADE, related_name='clubs')
    clubID = models.ForeignKey(Club, on_delete=models.CASCADE)
    isMember = models.BooleanField(default=False)
    isManager = models.BooleanField(default=False)

class Event(models.Model):
    eventName = models.CharField(max_length=80)
    timeStart = models.DateTimeField()
    timeEnd = models.DateTimeField()
    location = models.CharField(max_length=100)
    club = models.ForeignKey(Club, on_delete=models.CASCADE)
    reoccurring = models.BooleanField(default=False)

class EventAttendance(models.Model):
    userID = models.ForeignKey(User, on_delete=models.CASCADE)
    eventID = models.ForeignKey(Event, on_delete=models.CASCADE)
    attending = models.BooleanField(default=False)