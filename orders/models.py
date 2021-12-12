from django.db import models
from django.db.models.aggregates import Sum
from django.db.models.deletion import CASCADE
from django.http import request
from django.utils import timezone
from user.models import Account
from showroom.models import Variant,Vehicle
from vendor.models import Vendor
from datetime import datetime
# Create your models here.

class Payments(models.Model):
    user=models.ForeignKey(Account,on_delete=models.CASCADE)
    payment_id=models.CharField(max_length=100)
    payment_method=models.CharField(max_length=100)
    amount_paid=models.CharField(max_length=100)
    status=models.CharField(max_length=100)
    created_at=models.DateTimeField(auto_now_add=True)
    class Meta:
        verbose_name        ='payment'
        verbose_name_plural ='payments'

    def __str__(self):
        return self.payment_id

class Order(models.Model):
    STATUS=(
        ('Offline Verification Stage','Offline Verification Stage'),('Vehicle Delivered','Vehicle Delivered'),('Offline verification Failed','Offline verification Failed'),('Cancelled','Cancelled'),
    )
    PAYMENTS=(
        ('Paypal','Paypal'),
        ('Razorpay','Razorpay')
    )

    user=models.ForeignKey(Account,on_delete=models.SET_NULL,null=True)
    payment=models.ForeignKey(Payments,on_delete=models.SET_NULL,blank=True,null=True)
    
    
    full_name=models.CharField(max_length=50)
    address_line_1=models.CharField(max_length=50)
    address_line_2=models.CharField(max_length=50)
    city=models.CharField(max_length=50)
    zip_code=models.BigIntegerField()
    state=models.CharField(max_length=50,null=True)
    country=models.CharField(max_length=50)
    mobile=models.BigIntegerField()
    landmark=models.CharField(max_length=50)
    
    payment_option=models.CharField(max_length=10, choices=PAYMENTS, null=True,blank=False)
    order_number=models.CharField(max_length=20)
    order_total=models.FloatField(default=1)
    pending_amount=models.BigIntegerField(default=0)
    tax=models.FloatField()
    discount_price=models.FloatField(default=0)
    status=models.CharField(max_length=100,default='Booking Payment pending')
    ip=models.CharField(blank=True,max_length=20)
    is_ordered=models.BooleanField(default=False)   
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.full_name
    
    def full_address(self):
        return f'{self.address_line_1} {self.address_line_2}'

class OrderVehicle(models.Model):
    order=models.ForeignKey(Order,on_delete=models.CASCADE)
    payment=models.ForeignKey(Payments,on_delete=models.SET_NULL,blank=True,null=True)
    user=models.ForeignKey(Account,on_delete=models.CASCADE)
    vendor=models.ForeignKey(Vendor,on_delete=models.CASCADE,default=None)
    vehicle=models.ForeignKey(Vehicle,on_delete=models.CASCADE)
    variant=models.ForeignKey(Variant,on_delete=models.CASCADE)
    quantity=models.IntegerField(default=0)
    price=models.FloatField(default=0)
    paid=models.FloatField(default=0)
    ordered=models.BooleanField(default=False)
    status=models.CharField(max_length=100,default='Offline verification Pending')
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now=True)

    def get_date(self):
        time = datetime.now()
        if self.created_at.day == time.day:
            return str(time.hour - self.created_at.hour-5) + " hours ago"
        else:
            if self.created_at.month == time.month:
                return str(time.day - self.created_at.day) + " days ago"
            else:
                if self.created_at.year == time.year:
                    return str(time.month - self.created_at.month) + " months ago"
        return self.created_at


    
    def __int__(self):
        return self.vehicle
    
    

