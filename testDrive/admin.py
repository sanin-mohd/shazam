from django.contrib import admin
from . models import Slots
# Register your models here.
class SlotsAdmin(admin.ModelAdmin):
    model = Slots
    list_display = ('vehicle','slots','date_time') 
    filter_horizontal =()
    list_filter = ()
    fieldsets =()
admin.site.register(Slots,SlotsAdmin)