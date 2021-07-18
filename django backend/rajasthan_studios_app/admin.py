from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import Coaches,Appointment
# Register your models here.
@admin.register(Coaches)
class CoachesAdmin(ImportExportModelAdmin):
    pass