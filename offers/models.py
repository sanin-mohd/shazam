from django.db import models
import uuid

from django.db.models.deletion import CASCADE

from showroom.models import Vehicle
from vendor.models import Vendor
# Create your models here.

class VehicleOffer(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    vendor=models.ForeignKey(Vendor,on_delete=models.CASCADE,null=True)
    vehicle = models.OneToOneField(Vehicle, on_delete=models.CASCADE,unique=True)
    discount = models.PositiveIntegerField(help_text='Offer in percentage',default=0)
    is_active = models.BooleanField(default=True)
    

    def __str__(self):
        return str(self.discount)