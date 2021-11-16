from django.db import models


# Create your models here.
class Category(models.Model):
    category_name=models.CharField(max_length=50,unique=True)
    slug=models.SlugField(max_length=100,unique=True)
    gif= models.URLField(max_length=1000,default='None')
    
    class Meta:
        verbose_name        ='Category'
        verbose_name_plural ='Categories'
    def __str__(self):
        return self.category_name
    
    