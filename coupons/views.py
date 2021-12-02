from django.shortcuts import redirect, render
from django.contrib import messages, auth
from showroom.models import Vehicle
from vendor.models import Vendor
from .models import Coupon
from category.models import Category
# Create your views here.

def coupons_table(request):
    
    coupons=Coupon.objects.all()
    context={

        'coupons':coupons,
     
    }
    return render(request,'superadmin/coupons.html',context)
def add_coupon(request):
    if request.method=="POST":
        category   =   request.POST['category']
        discount   =   request.POST['discount']
        code       =   request.POST['code']
        

        try:
            category=Category.objects.get(id=category)
            Coupon.objects.create(discount=discount,code=code,category=category)
        except:
            messages.error(request,'This coupon code is taken')
            return redirect('add_coupon')
        return redirect('coupons_table')
    categories=Category.objects.all()
    return render(request,'superadmin/add_coupon.html',{'categories':categories})


def delete_coupon(request,id):
    
    coupon=Coupon.objects.get(id=id)
    coupon.delete()
    return redirect('coupons_table')

def block_coupon(request,id):
    coupon=Coupon.objects.get(id=id)
    coupon.is_active=False
    coupon.save()
    return redirect('coupons_table')

def unblock_coupon(request,id):
    coupon=Coupon.objects.get(id=id)
    coupon.is_active=True
    coupon.save()
    return redirect('coupons_table')