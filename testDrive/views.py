from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from . models import Slots
from showroom.models import ReviewRating, Vehicle
# Create your views here.

@login_required(login_url='login')
def show_slots(request,vehicle_id):
        slots = Slots.objects.filter(vehicle=vehicle_id)
        vehicle = Vehicle.objects.get(id=vehicle_id)
        reviews=ReviewRating.objects.filter(vehicle=vehicle,status=True)
        review_count=reviews.count()
        rating=0
        for review in reviews:
            rating += review.rating
        try:
            rating=rating/review_count
        except:
            rating=0
        contex = {
                'slots': slots,
                'vehicle':vehicle,
                'review_count': review_count,
                'rating': rating
            }
        print(slots)
        return render(request, 'slots.html', contex)