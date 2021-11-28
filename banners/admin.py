from django.contrib import admin
from .models import Banner
# Register your models here.
class BannerAdmin(admin.ModelAdmin):
    list_display    =   ['name','poster','created_at']

admin.site.register(Banner,BannerAdmin)