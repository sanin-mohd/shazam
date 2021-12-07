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
    path('new_booking',views.new_booking,name='new_booking'),
    path('approved_booking',views.approved_booking,name='approved_booking'),
    path('cancelled_booking',views.cancelled_booking,name='cancelled_booking'),
    path('completed_booking',views.completed_booking,name='completed_booking'),
    path('verify_booking/<int:ordervehicle>',views.verify_booking,name='verify_booking'),
    path('change_delivery_status/<int:ordervehicle>',views.change_delivery_status,name='change_delivery_status'),
    path('report',views.report,name='report'),
    path('download_vendor_report',views.download_vendor_report,name='download_vendor_report'),
    path('vendor_sales',views.vendor_sales,name='vendor_sales'),
    path('download_vendor_sales_report',views.download_vendor_sales_report,name='download_vendor_sales_report'),
    
    



    
    


]