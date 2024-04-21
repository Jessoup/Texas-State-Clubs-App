# Generated by Django 5.0.4 on 2024-04-04 23:55

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('userID', models.AutoField(primary_key=True, serialize=False)),
                ('firstName', models.CharField(max_length=80)),
                ('lastName', models.CharField(max_length=80)),
                ('userName', models.CharField(max_length=50)),
                ('passWord', models.CharField(max_length=30)),
                ('isManager', models.BooleanField(default=False)),
                ('isAdmin', models.BooleanField(default=False)),
            ],
        ),
    ]
