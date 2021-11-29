from django.db import models
from django.db.models.aggregates import Variance
from django.db.models.base import Model
from django.db.models.fields import CharField, DateTimeField
from showroom.models import Variant,Vehicle
from user.models import Account
# Create your models here.

class Cart(models.Model):
    cart_id=models.CharField(max_length=250,blank=True)
    date_added=models.DateTimeField(auto_now_add=True)
    
    
    def __int__(self):
        return self.cart_id
    
class CartItem(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
    variant=models.ForeignKey(Variant,on_delete=models.CASCADE)
    cart_id=models.ForeignKey(Cart,on_delete=models.CASCADE,null=True)
    quantity=models.IntegerField()
    is_active=models.BooleanField(default=True)

    def sub_total(self):
        return self.variant.get_price()*self.quantity
    def booking_price(self):
        return self.quantity*999

    def __int__(self):
        return self.variant 