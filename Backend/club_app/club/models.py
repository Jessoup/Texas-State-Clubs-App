from django.db import models

# Create your models here.
class Club(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField()

    def __str__(self):
        return str(self.title)