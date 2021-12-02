from django.db import models
from category.models import Category
# Create your models here.
class BookingPrice(models.Model):
    category=models.OneToOneField(Category,on_delete=models.CASCADE)
    booking_price=models.IntegerField(default=999)

    def __int__(self):
        return self.booking_price