from django.shortcuts import redirect, render
from django.contrib import messages, auth
from showroom.models import Vehicle
from vendor.models import Vendor
from .models import VehicleOffer
# Create your views here.

def offers_table(request):
    vendor=Vendor.objects.get(email=request.user)
    offers=VehicleOffer.objects.filter(vendor=vendor)
    context={
        'offers':offers,
        'vendor':vendor,

    }
    return render(request,'vendor/offers.html',context)
def add_offer(request):
    
    vendor=Vendor.objects.get(email=request.user)
    vehicles=Vehicle.objects.filter(vendor_id=vendor)
    context={
        'vendor':vendor,
        'vehicles':vehicles,
    }
    if request.method=="POST":
        
        
        discount   =   request.POST['discount']
        vehicle_id       =   request.POST['vehicle']
        vehicle          =   Vehicle.objects.get(id=vehicle_id)

        try:
            
            VehicleOffer.objects.create(vendor=vendor,discount=discount,vehicle=vehicle)
        except:
            messages.error(request,'One offer is already exsisting for the vehicle..')
            return redirect('add_offer')
        return redirect('offers_table')
        
    return render(request,'vendor/add_offer.html',context)


def delete_offer(request,id):
    
    vehicleOffer=VehicleOffer.objects.get(id=id)
    vehicleOffer.delete()
    return redirect('offers_table')

def block_offer(request,id):
    vehicleOffer=VehicleOffer.objects.get(id=id)
    vehicleOffer.is_active=False
    vehicleOffer.save()
    return redirect('offers_table')

def unblock_offer(request,id):
    vehicleOffer=VehicleOffer.objects.get(id=id)
    vehicleOffer.is_active=True
    vehicleOffer.save()
    return redirect('offers_table')
