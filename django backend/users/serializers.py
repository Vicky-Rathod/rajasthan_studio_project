from django.contrib.auth.models import User
from rest_framework import serializers

# User Model Serializers to create Appointemnt with the coach


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['username', 'email']