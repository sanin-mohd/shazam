from django.urls import path
from . import views
urlpatterns = [
    path('<int:vehicle_id>',views.show_slots,name='show_slots'),
]