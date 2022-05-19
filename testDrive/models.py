from datetime import date, datetime, timedelta
from django.db import models
from django.contrib.postgres.fields import ArrayField
from showroom.models import Vehicle
from user.models import Account
from django.utils import timezone

# Create your models here.
class Slots(models.Model):
    vehicle=models.ForeignKey(Vehicle,on_delete=models.CASCADE)
    slots=models.IntegerField(default=5)
    date_time=models.DateTimeField(default = datetime.now() + timedelta(days=7))
    active = models.BooleanField(default=True)
    
    def validate_database(self):
        if self.date_time<=timezone.now():
            self.active = False
            self.save()
        
class TestDriveUsers(models.Model):
    slot=models.ForeignKey(Slots,on_delete=models.CASCADE)
    user_id = models.ForeignKey(Account,on_delete=models.CASCADE)
    active = models.BooleanField(default=True)
    completed=models.BooleanField(default=False)

