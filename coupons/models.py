from django.db import models
import uuid
from showroom.models import Vehicle
from vendor.models import Vendor
from user.models import Account
from category.models import Category
# Create your models here.
class Coupon(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    code=models.CharField(max_length=10,unique=True)
    discount = models.PositiveIntegerField(help_text='Offer in percentage',default=0)
    is_active = models.BooleanField(default=True)
    created_at=models.DateTimeField(auto_now_add=True)
    

    def __int__(self):
        return str(self.discount)

class RedeemedCoupon(models.Model):
    coupon=models.ForeignKey(Coupon,on_delete=models.CASCADE)
    user=models.ForeignKey(Account,on_delete=models.CASCADE)
    