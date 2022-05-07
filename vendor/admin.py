from django.contrib import admin

from . models import Vendor
# Register your models here.
class VendorAdmin(admin.ModelAdmin):
    model = Vendor
    list_display = ('vendor_name','GST_number','email', 'mobile','is_verified','is_active','date_joined') 
    readonly_fields = ('last_login','date_joined')
    ordering = ('date_joined', )
    filter_horizontal =()
    list_filter = ()
    fieldsets =()
admin.site.register(Vendor,VendorAdmin)
