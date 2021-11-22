from django.contrib import admin
from django.db import models
from .models import Vehicle,Variant
# Register your models here.

class VehicleAdmin(admin.ModelAdmin):
    list_display=('vehicle_name','vendor_id','slug','gif','range','top_speed','no_of_seats','category','created_date')
    prepopulated_fields={'slug':('vehicle_name',)}

class VariantAdmin(admin.ModelAdmin):
    list_display=('vehicle_id','color','color_name','slug','image1','image2','image3','price','remaining')
    prepopulated_fields={'slug':('color_name',)}

admin.site.register(Variant,VariantAdmin)


admin.site.register(Vehicle,VehicleAdmin)