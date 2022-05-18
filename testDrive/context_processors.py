
from .models import Slots, TestDriveUsers
from django.contrib import messages, auth

def active_test_drive(request):
    context = {'booked_slot': None}
    user = request.user
    if not user:
        return context
    try:
        booked_slot = TestDriveUsers.objects.get(user_id=user,active = True)
        vehicle = booked_slot.slot.vehicle
        company = vehicle.vendor_id
        date = booked_slot.slot.date_time
        context = {'booked_slot': booked_slot,'user': user,'vehicle': vehicle,'date':date,'company':company}
    except:
        pass
    
    return context