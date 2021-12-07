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
    path('view-categories',views.view_Categories,name='view-categories'),
    path('add-category',views.add_Category,name='add-category'),
    path('edit-category/<int:pk>',views.edit_category,name='edit-category'),
    path('delete-category/<int:pk>',views.delete_category,name='delete-category'),
    path('price_table',views.price_table,name='price_table'),
    path('add_price',views.add_price,name='add_price'),
    path('edit_price/<str:id>',views.edit_price,name='edit_price'),
    path('admin_report',views.admin_report,name='admin_report'),
    path('download_admin_report',views.download_admin_report,name='download_admin_report'),

    
    


]



    

