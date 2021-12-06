from django.shortcuts import redirect, render
from django.contrib import messages, auth
from showroom.models import Vehicle
from vendor.models import Vendor
from .models import Coupon, RedeemedCoupon
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
        
        discount   =   request.POST['discount']
        code       =   request.POST['code']
        

        try:
            
            Coupon.objects.create(discount=discount,code=code)
        except:

            messages.error(request,'This coupon code is taken')
            return redirect('add_coupon')
        return redirect('coupons_table')
    
    return render(request,'superadmin/add_coupon.html')


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

def redeem_coupon(request):
    user=request.user
    if request.method == "POST":
        code=request.POST['code']

        try:
            coupon          =   Coupon.objects.get(code=code)
            request.session['coupon_id']=str(coupon.id)
            request.session['code']=code
            request.session['coupon_discount_perc']=coupon.discount
        except:
            try:
                del request.session['coupon_id']
                del request.session['code']
                del request.session['coupon_discount_perc']
                del request.session['discount_price']
            except:
                pass
            messages.error(request,"Coupon Not Valid")
            request.session['coupon_id']=0
            request.session['coupon_discount_perc']=0
            return redirect('checkout')
        try:
            redeemed_coupon =   RedeemedCoupon.objects.get(user=user,coupon=coupon)

        except:
            redeemed_coupon=None

        if redeemed_coupon is None:
            
            #RedeemedCoupon.objects.create(user=user,coupon=coupon)
            if coupon.is_active:

                request.session['coupon_discount_perc']=coupon.discount
                messages.success(request,"Coupon applied.."+str(coupon.discount)+"% "+str("Discounted"))
                return redirect('checkout')
                
            else:
                print("This coupon is expired")
                
                messages.error(request,"This coupon is expired")
                return redirect('checkout')
        else:
            messages.error(request,"You have already redeemed this coupon")
            return redirect('checkout')
    else:
        return redirect('checkout')

