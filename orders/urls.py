from django.urls import path
from . import views

urlpatterns = [
    path('book_now',views.book_now,name='book_now'),
    path('pay_now',views.pay_now,name='pay_now'),
    path('update_payment',views.update_payment,name='update_payment'),
    path('razorpay_payment_verification',views.razorpay_payment_verification,name='razorpay_payment_verification'),
    path('payment_failed',views.payment_failed,name='payment_failed'),
    path('booking_reciept',views.booking_reciept,name='booking_reciept'),
    path('ordered_details',views.ordered_details,name='ordered_details'),
    path('cancel_booking/<int:order_number>',views.cancel_booking,name='cancel_booking'),
    path('old_reciept/<str:order_number>',views.old_reciept,name='old_reciept'),
    
    


    


]