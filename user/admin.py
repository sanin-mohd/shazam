from django.contrib import admin
from django.db.models.base import Model
from django.forms import fields
from . models import Account
class AccountAdmin(admin.ModelAdmin):
    model = Account
    list_display = ('first_name', 'email', 'mobile', 'gender','is_staff','is_verified','is_active','last_login','date_joined') 
    
    readonly_fields = ('last_login','date_joined')
    ordering = ('date_joined', )
    filter_horizontal =()
    list_filter = ()
    fieldsets =()

# Register your models here.

admin.site.register(Account,AccountAdmin)