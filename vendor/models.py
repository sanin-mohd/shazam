from django.db import models
from django.db.models.base import Model

# Create your models here.


class Vendor(models.Model):
    vendor_name      =models.CharField(max_length=50,unique=True)
    GST_number       =models.CharField(max_length=8,unique=True)
    email           =models.EmailField(max_length=100,unique=True) 
    mobile          =models.CharField(max_length=10,unique=True)
    logo            =models.ImageField(upload_to='photos/vendors_logo/',blank='true')
    password        =models.CharField(max_length=20,blank=False,default="1234")


    date_joined     =models.DateTimeField(auto_now_add=True)
    last_login      =models.DateTimeField(auto_now_add=True)
    is_admin        =models.BooleanField(default=False)
    is_staff        =models.BooleanField(default=True)
    is_verified     =models.BooleanField(default=False)
    is_mobile_verified=models.BooleanField(default=False)
    is_active       =models.BooleanField(default=True)
    is_superadmin   =models.BooleanField(default=False)

    USERNAME_FIELD  ='vendor_name'
    REQUIRED_FIELDS =['email','GST_nmuber','mobile','logo']
    

    def __str__(self):
        return self.vendor_name
    def has_perm(self,perm,obj=None):
        return self.is_admin
    def has_module_perms(self,add_label):
        return True
    

    
