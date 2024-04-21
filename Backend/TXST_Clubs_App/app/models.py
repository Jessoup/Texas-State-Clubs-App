from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class CustomUser(AbstractUser):
    # default fields:
    # username
    # first_name
    # last_name
    # email
    # password
    # is_staff
    # is_superuser
    pass

    def __str__(self):
        return self.username

    #class Meta:
    #    ordering = ['-created']

class Club(models.Model):
    clubName = models.CharField(max_length=80)
    clubDescription = models.TextField(max_length=200)

class UserClubRelation(models.Model):
    userID = models.ForeignKey(CustomUser, on_delete=models.CASCADE, related_name='clubs')
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
    userID = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    eventID = models.ForeignKey(Event, on_delete=models.CASCADE)
    attending = models.BooleanField(default=False)