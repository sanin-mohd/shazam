from django.urls import path
from django.urls.resolvers import URLPattern
from . import views


urlpatterns=[
    path('',views.banners_table,name='banners_table'),
    path('add_banner',views.add_banner,name='add_banner'),
    path('delete_banner/<int:id>',views.delete_banner,name='delete_banner'),

]