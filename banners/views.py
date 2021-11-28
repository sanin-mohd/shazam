from django.shortcuts import redirect, render
from vendor.models import Vendor
from .models import Banner
# Create your views here.

def banners_table(request):
    vendor=Vendor.objects.get(email=request.user)
    banners=Banner.objects.filter(vendor=vendor)
    context={
        'banners':banners,
        'vendor':vendor,

    }
    return render(request,'vendor/banners.html',context)
def add_banner(request):
    vendor=Vendor.objects.get(email=request.user)
    context={
        'vendor':vendor,
    }
    if request.method=="POST":
        
        name     =   request.POST['name']
        poster   =   request.FILES.get('poster')
        
        Banner.objects.create(vendor=vendor,name=name,poster=poster)
        return redirect('banners_table')
        
    return render(request,'vendor/add_banner.html',context)

def delete_banner(request,id):
    banner=Banner.objects.get(id=id)
    banner.delete()
    return redirect('banners_table')