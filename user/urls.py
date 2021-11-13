from django.urls import path
from . import views

urlpatterns = [
    
    path('',views.home,name='home'),
    path('login',views.login,name='login'),
    path('register',views.register,name='register'),
    path('logout',views.logout,name='logout'),
    path('send-otp',views.verify_otp,name='send-otp'),
    path('verify-otp',views.verify_otp,name='verify-otp'),

]