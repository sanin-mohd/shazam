from django.utils import timezone
from typing import Tuple
from django.core.validators import slug_re
from django.db import models
from django.db.models.aggregates import Sum
from django.db.models.deletion import Collector
from django.db.models.fields import BooleanField, CharField, DateTimeField, SlugField
from colorfield.fields import ColorField
from django.http import request
from category.models import Category


from vendor.models import Vendor
from user.models import Account
from django.db.models import Avg
from django.apps import apps

# Create your models here.
class Vehicle(models.Model):
    vehicle_name    =models.CharField(max_length=200 , unique=True)
    vendor_id       =models.ForeignKey(Vendor,on_delete=models.CASCADE,default=None)
    slug            =models.SlugField(max_length=200, unique=True)
    range           =models.IntegerField()
    top_speed       =models.IntegerField()
    category        =models.ForeignKey(Category,on_delete=models.CASCADE)
    gif             =models.URLField(max_length=200,default=None)
    no_of_seats     =models.IntegerField(default=5)
    #no need to mention foreignkey of offer since offer tabel has OneToOne field to vehicle 
    created_date    =models.DateTimeField(auto_now_add=True)
    modified_date   =models.DateTimeField(auto_now_add=True)
    is_available    =models.BooleanField(default=True)

    def rating(self):
        reviews=ReviewRating.objects.filter(vehicle=self,status=True)
        review_count=reviews.count()
        rating=0
        for review in reviews:
            rating += review.rating
        try:
            rating=rating/review_count
        except:
            rating=0
        print(reviews.count())
        print("<------||||||||||||---->")
        return rating
    def review_count(self):
        reviews=ReviewRating.objects.filter(vehicle=self,status=True)
        review_count=reviews.count()
        return review_count
    def __str__(self):
        return self.vehicle_name
    class Meta:
        ordering = ('created_date',)
    

    
    

class Variant(models.Model):
    vehicle_id      =models.ForeignKey(Vehicle,on_delete=models.CASCADE)
    color           =ColorField(default='#FF0000')
    color_name       =models.CharField(max_length=100)
    slug            =models.SlugField(max_length=200)
    image1          =models.ImageField(upload_to='photos/vehicles/',blank=True)
    image2          =models.ImageField(upload_to='photos/vehicles/',blank=True)
    image3          =models.ImageField(upload_to='photos/vehicles/',blank=True)
    price           =models.IntegerField()
    remaining       =models.IntegerField()
    is_available    =models.BooleanField(default=True)
    
    def get_price(self):
        try:
            if self.vehicle_id.vehicleoffer.is_active:
                offer_price = (self.price / 100) * self.vehicle_id.vehicleoffer.discount
                discounted_price = self.price - offer_price
                return discounted_price
            raise
        except:
            pass
            return self.price
    def get_revenue(self,month=timezone.now().month):
        
        vendor=self.vehicle_id.vendor_id
        MyModel = apps.get_model('orders', 'OrderVehicle')
        orders=MyModel.objects.filter(vendor_id=vendor,created_at__month=month,status="Completed",variant=self)
        return orders.values('variant').annotate(revenue=Sum('price'))
    def get_profit(self,month=timezone.now().month):
        
        vendor=self.vehicle_id.vendor_id
        MyModel = apps.get_model('orders', 'OrderVehicle')
        orders=MyModel.objects.filter(vendor_id=vendor,created_at__month=month,status="Completed",variant=self)
        profit_calculted=orders.values('variant').annotate(profit=Sum('price'))
        profit_calculated=profit_calculted[0]['profit']*0.23
        return profit_calculated
    def get_count(self,month=timezone.now().month):
        
        vendor=self.vehicle_id.vendor_id
        MyModel = apps.get_model('orders', 'OrderVehicle')
        orders=MyModel.objects.filter(vendor_id=vendor,created_at__month=month,status="Completed",variant=self)
        return orders.values('variant').annotate(quantity=Sum('quantity'))
        

class ReviewRating(models.Model):
    vehicle     =   models.ForeignKey(Vehicle,on_delete=models.CASCADE)
    user        =   models.ForeignKey(Account,on_delete=models.CASCADE)
    subject     =   models.CharField(max_length=200,blank=True)
    review      =   models.TextField(max_length=500,blank=True)
    rating      =   models.FloatField()
    ip          =   models.CharField(max_length=20,blank=True)
    status      =   BooleanField(default=True)
    created_at  =   DateTimeField(auto_now_add=True)
    updated_at  =   DateTimeField(auto_now=True)
    def __str__(self):
        return self.subject
