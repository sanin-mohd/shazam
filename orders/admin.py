from django.contrib import admin
from .models import Payments,Order,OrderVehicle
# Register your models here.
class  OrderVehicleInline(admin.TabularInline):
    model = OrderVehicle

class OrderAdmin(admin.ModelAdmin):
    list_display    =   ['order_number','full_name','user','mobile','order_total','pending_amount','tax','status','is_ordered','created_at']
    list_filter     =   ['status','is_ordered']
    search_fields   =   ['order_number','full_name','user','mobile']
    list_per_page   =   20
    inlines         =   [OrderVehicleInline]

class OrderVehicleAdmin(admin.ModelAdmin):
    list_display    =   ['order','payment','user','variant','price','paid','status']
    search_fields   =   ['order','user','payment']
    list_per_page   =   20

admin.site.register(Payments)
admin.site.register(Order,OrderAdmin)
admin.site.register(OrderVehicle,OrderVehicleAdmin)

