from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from . models import Slots, TestDriveUsers
from django.contrib import messages, auth
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
    
def book_slot(request,slot_id):
    slot=Slots.objects.get(id=slot_id)
    vehicle = slot.vehicle_id
    user = request.user
    print(vehicle)
    try:
        booked_user = TestDriveUsers.objects.get(user_id=user)
        messages.error(request,"Sorry, At a time only one test drive is provided for a user")
        return redirect('show_slots',vehicle)
    except :
        pass
        
    if slot.slots:
        slot.slots = slot.slots-1
        slot.save()
        booked_user = TestDriveUsers.objects.create(user_id=user,slot=slot)
        messages.success(request, f"Slot booked for {slot.date_time}, You will be contacted by our customer support")
    else:
        messages.error(request, 'Sorry,You have selected Unavailable slot')
    
    return redirect('show_slots',vehicle)
    