from django.db import models
from datetime import datetime

from vendor.models import Vendor
# Create your models here.
class Banner(models.Model):
    vendor      =   models.ForeignKey(Vendor,on_delete=models.CASCADE)
    name        =   models.CharField(max_length=250)
    poster      =   models.ImageField(upload_to='photos/banners/',blank=True)
    status      =   models.CharField(max_length=20,default='Active')

    created_at  =   models.DateTimeField(auto_now_add=True)
    
    def get_date(self):
        time = datetime.now()
        if self.created_at.day == time.day:
            return str(time.hour - self.created_at.hour) + " hours ago"
        else:
            if self.created_at.month == time.month:
                return str(time.day - self.created_at.day) + " days ago"
            else:
                if self.created_at.year == time.year:
                    return str(time.month - self.created_at.month) + " months ago"
        return self.created_at
    def __int__(self):
        return self.id