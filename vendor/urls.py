from django.urls import path
from . import views

urlpatterns = [
    
    path('',views.vendor_dashboard,name='vendor'),
    path('vendor-login',views.vendor_login,name='vendor-login'),
    path('vendor-register',views.vendor_register,name='vendor-register'),
    path('vendor-logout',views.vendor_logout,name='vendor-logout'),

]