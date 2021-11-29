from django.contrib import admin
from django.db import models
from .models import VehicleOffer
# Register your models here.
class VehicleOfferAdmin(admin.ModelAdmin):
    list_display=('vehicle','discount','is_active')
admin.site.register(VehicleOffer,VehicleOfferAdmin)