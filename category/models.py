from django.db import models


# Create your models here.
class Category(models.Model):
    name=models.CharField(max_length=50,unique=True)
    slug=models.SlugField(max_length=100,unique=True)
    image=models.ImageField(upload_to='photos/categories/',blank=False)
    
    class Meta:
        verbose_name        ='Category'
        verbose_name_plural ='Categories'
    def __str__(self):
        return self.name
    