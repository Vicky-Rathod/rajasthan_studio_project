from rest_framework import serializers
from .models import Appointment

# Appointment Serializer will have one to many relationship with user 

class AppointmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = ['id', 'user', 'coach', 'timezone','day_of_week','time_interval']