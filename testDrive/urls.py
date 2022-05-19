from django.urls import path
from . import views
urlpatterns = [
    path('<int:vehicle_id>',views.show_slots,name='show_slots'),
    path('book_slot/<int:slot_id>',views.book_slot,name='book_slot'),
    
]