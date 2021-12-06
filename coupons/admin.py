from django.contrib import admin

from coupons.models import Coupon,RedeemedCoupon

# Register your models here.
class CouponAdmin(admin.ModelAdmin):
    list_display    =   ['code','discount','is_active']
class RedeemedCouponAdmin(admin.ModelAdmin):
    list_display    =   ['user','coupon']

admin.site.register(Coupon,CouponAdmin)
admin.site.register(RedeemedCoupon,RedeemedCouponAdmin)