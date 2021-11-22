from django.urls import path
from . import views

urlpatterns = [
    
    path('',views.vendor_dashboard,name='vendor'),
    path('vendor-login',views.vendor_login,name='vendor-login'),
    path('vendor-register',views.vendor_register,name='vendor-register'),
    path('vendor-logout',views.vendor_logout,name='vendor-logout'),
    path('vendor-otp',views.otp,name='vendor-otp'),
    path('view-vehicles',views.view_vehicles,name='view-vehicles'),
    path('add-vehicle',views.add_vehicle,name='add-vehicle'),
    path('edit-vehicle/<int:pk>',views.edit_vehicle,name='edit-vehicle'),
    path('delete-vehicle/<int:pk>',views.delete_vehicle,name='delete-vehicle'),
    path('view-variants/<int:pk>',views.view_variants,name='view-variants'),
    path('edit-variant/<int:pk>',views.edit_variant,name='edit-variant'),
    path('add-variant/<int:pk>',views.add_variant,name='add-variant'),
    path('delete-variant/<int:pk>',views.delete_variant,name='delete-variant'),
    
    


]