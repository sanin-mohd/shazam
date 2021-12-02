
from django.urls import path
from django.urls.resolvers import URLPattern
from . import views

urlpatterns=[
    path('',views.coupons_table,name='coupons_table'),
    path('add_coupon',views.add_coupon,name='add_coupon'),
    path('delete_coupon/<str:id>',views.delete_coupon,name='delete_coupon'),
    path('block_coupon/<str:id>',views.block_coupon,name='block_coupon'),
    path('unblock_coupon/<str:id>',views.unblock_coupon,name='unblock_coupon'),

]