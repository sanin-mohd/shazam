from os import name
from django.urls import path
from django.urls.resolvers import URLPattern
from . import views


urlpatterns=[
    path('',views.offers_table,name='offers_table'),
    path('add_offer',views.add_offer,name='add_offer'),
    path('delete_offer/<str:id>',views.delete_offer,name='delete_offer'),
    path('block_offer/<str:id>',views.block_offer,name='block_offer'),
    path('unblock_offer/<str:id>',views.unblock_offer,name='unblock_offer'),

]