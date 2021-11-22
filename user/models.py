from django.db import models
from django.db.models.base import Model
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser
# Create your models here.
GENDER_CHOICES = (
        ('Male', 'Male'),
        ('Female', 'Female'),
    )

class MyAccountManager(BaseUserManager):
    def create_user(self,first_name,last_name,email,mobile,gender,password=None,is_staff=False):
        if not email:
            raise ValueError('User must have an email address')
        if not mobile:
            raise ValueError('User must have mobile')
        user=self.model(
            email       =self.normalize_email(email),
            mobile      =mobile,
            first_name  =first_name,
            last_name   =last_name,
            gender      =gender,


        )
        user.set_password(password)
        user.save(using=self._db)
        return user
    def create_vendor(self,email,password=None):
        if not email:
            raise ValueError('Vendor must have an email address')
        
        vendor=self.model(
            email       =self.normalize_email(email),
            
            


        )
        vendor.is_admin=False
        vendor.is_active=True
        vendor.is_verified=False
        vendor.is_staff=True
        vendor.is_superadmin=False
        vendor.set_password(password)
        vendor.save(using=self._db)
        return vendor


    def create_superuser(self,email,first_name,last_name,gender,mobile,password):
        user=self.create_user(
            email=self.normalize_email(email),
            mobile=mobile,
            first_name=first_name,
            last_name=last_name,
            password=password,
            gender=gender,

        )
        user.is_admin=True
        user.is_active=True
        user.is_staff=True
        user.is_superadmin=True
        user.save(using=self._db)
        return user



class Account(AbstractBaseUser):
    first_name      =models.CharField(max_length=50)
    last_name       =models.CharField(max_length=50)
    email           =models.EmailField(max_length=100,unique=True) 
    mobile          =models.CharField(max_length=10,unique=True,null=True)
    gender          = models.CharField(max_length=10, choices=GENDER_CHOICES, null=True,blank=False)
    dp              =models.ImageField(upload_to='photos/users_dp/',blank=True)


    date_joined     =models.DateTimeField(auto_now_add=True)
    last_login      =models.DateTimeField(auto_now_add=True)
    is_admin        =models.BooleanField(default=False)
    is_staff        =models.BooleanField(default=False)
    is_active       =models.BooleanField(default=True)
    is_verified     =models.BooleanField(default=False)
    otp_verified    =models.BooleanField(default=False)
    is_superadmin   =models.BooleanField(default=False)

    USERNAME_FIELD  ='email'
    REQUIRED_FIELDS =['first_name', 'last_name', 'gender', 'mobile']
    
    objects=MyAccountManager()

    def __str__(self):
        return self.email
    def has_perm(self,perm,obj=None):
        return self.is_admin
    def has_module_perms(self,add_label):
        return True
    

 
