from django.db import models

# Create your models here.
class User(models.Model):
    firstName = models.CharField(max_length=80)
    lastName = models.CharField(max_length=80)
    userName = models.CharField(max_length=50)
    password = models.CharField(max_length=30)
    isAdmin = models.BooleanField(default=False)

    def __str__(self):
        return self.firstName + ' ' + self.lastName

    #class Meta:
    #    ordering = ['-created']

class Club(models.Model):
    clubName = models.CharField(max_length=80)
    clubDescription = models.TextField(max_length=200)

class UserClubRelation(models.Model):
    userID = models.ForeignKey(User, on_delete=models.CASCADE)
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