from django.core.validators import slug_re
from django.db import models
from django.db.models.deletion import Collector
from django.db.models.fields import CharField, SlugField
from colorfield.fields import ColorField
from category.models import Category
from vendor.models import Vendor



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

    created_date    =models.DateTimeField(auto_now_add=True)
    modified_date   =models.DateTimeField(auto_now_add=True)
    is_available    =models.BooleanField(default=True)

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
    def __str__(self):
        return self.color

