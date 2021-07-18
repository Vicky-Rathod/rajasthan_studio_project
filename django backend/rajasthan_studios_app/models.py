from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class Coaches(models.Model):
    name = models.CharField(max_length=100)
    time_z = models.CharField(max_length=100)
    day = models.CharField(max_length=100)
    available_at = models.CharField(max_length=100)
    available_until=models.CharField(max_length=100)



class Appointment(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    coach = models.CharField(max_length=100)
    timezone = models.CharField(max_length=100)
    day_of_week = models.CharField(max_length=100)
    time_interval = models.CharField(max_length=100)