from django.urls import path
from . import views

urlpatterns = [
    path('book_now',views.book_now,name='book_now'),
    path('pay_now',views.pay_now,name='pay_now'),
    


]