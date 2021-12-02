from django.contrib import admin
from .models import BookingPrice
# Register your models here.
class BookingPriceAdmin(admin.ModelAdmin):
    model = BookingPrice
    list_display = ('category', 'booking_price') 
    
admin.site.register(BookingPrice,BookingPriceAdmin)