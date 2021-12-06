from django.urls import path
from django.urls.resolvers import URLPattern
from . import views


urlpatterns=[
    path('',views.cart,name='cart'),
    path('add_quantity/<int:variant_id>',views.add_quantity,name='add_quantity'),
    path('decrement_quantity/<int:variant_id>',views.decrement_quantity,name='decrement_quantity'),
    path('remove_cart_item/<int:variant_id>',views.remove_cart_item,name='remove_cart_item'),
    path('checkout',views.checkout,name='checkout'),
    path('buy_now/<int:variant_id>',views.buy_now,name='buy_now'),
    


]