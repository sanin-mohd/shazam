from django.urls import path
from . import views
urlpatterns = [
    path('<int:id>',views.review,name='review'),

]