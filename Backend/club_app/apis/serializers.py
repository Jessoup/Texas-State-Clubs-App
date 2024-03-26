from rest_framework import serializers
from club import models

class ClubSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'description',
        )
        model=models.Club