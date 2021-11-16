from django.db import models
from django.db.models.deletion import Collector
from django.db.models.fields import CharField, SlugField

from category.models import Category



# Create your models here.
class Vehicle(models.Model):
    vehicle_name    =models.CharField(max_length=200 , unique=True)
    Slug            =models.SlugField(max_length=200, unique=True)
    range           =models.IntegerField()
    top_speed       =models.IntegerField()
    category        =models.ForeignKey(Category,on_delete=models.CASCADE)

    def __str__(self):
        return self.vehicle_name

