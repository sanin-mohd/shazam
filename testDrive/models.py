from datetime import date, datetime, timedelta
from django.db import models

from showroom.models import Vehicle

# Create your models here.
class Slots(models.Model):
    vehicle=models.ForeignKey(Vehicle,on_delete=models.CASCADE)
    slots=models.IntegerField(default=5)
    date_time=models.DateTimeField(default = datetime.now() + timedelta(days=7))
    

# class TestDrive
