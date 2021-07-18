from django.test import TestCase
from .models import Appointment
class AppointmentTestCase(TestCase):
    def setUp(self):
        Appointment.objects.create(user=1,coach = "John Doe",timezone = "(GMT-06:00) America/North_Dakota/New_Salem", day_of_week = "Tuesday", time_interval = "08:00 - 8:30")
        Appointment.objects.create(user=1,coach = "Jane Doe",timezone = "(GMT-06:00) Central Time (US & Canada)", day_of_week = "Sunday", time_interval = "09:00 - 09:30")

    def get_appointment_list(self):
        """Animals that can speak are correctly identified"""
        lion = Appointment.objects.get(coach="Jane Doe")
        cat = Appointment.objects.get(coach="John")