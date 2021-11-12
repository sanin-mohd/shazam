from django.urls import path
from . import views

urlpatterns = [
    
    path('',views.superadmin_dashboard,name='superadmin'),
    path('superadmin-login',views.superadmin_login,name='superadmin-login'),
    path('superadmin-logout',views.superadmin_logout,name='superadmin-logout'),
    path('vendor-list-for-verification',views.vendor_list_for_verification,name='vendor-list-for-verification'),
    path('verify-vendor/<int:pk>',views.verify_vendor,name='verify-vendor'),
    path('active-vendor-list',views.active_vendor_list,name='active-vendor-list'),
    path('block-vendor/<int:pk>',views.block_vendor,name='block-vendor'),
    path('unblock-vendor/<int:pk>',views.unblock_vendor,name='unblock-vendor'),
    path('delete-vendor/<int:pk>',views.delete_vendor,name='delete-vendor'),
    path('customer-list',views.customer_list,name='customer-list'),
    path('block-customer/<int:pk>',views.block_customer,name='block-customer'),
    path('unblock-customer/<int:pk>',views.unblock_customer,name='unblock-customer'),

]