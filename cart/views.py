from django.core.checks import messages
from django.http.response import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from category.models import Category
from coupons.views import redeem_coupon
from showroom.models import Vehicle,Variant
from superadmin.models import BookingPrice
from user.models import Account, Address
from .models import Cart,CartItem
from django.contrib.auth.decorators import login_required
from coupons.models import Coupon, RedeemedCoupon
# Create your views here.

def _cart_id(request):
    cart=request.session.session_key
    if not cart:
        cart=request.session.create()
    return cart

def add_quantity(request,variant_id):

    variant=Variant.objects.get(id=variant_id)
    

    if request.user.is_authenticated:
        is_cart_item_exists=CartItem.objects.filter(variant=variant,user=request.user).exists()
        if is_cart_item_exists:
            cart_item=CartItem.objects.get(user=request.user,variant=variant)
            cart_item.quantity += 1
            cart_item.save()
        else:
            cart_item=CartItem.objects.create(variant=variant,quantity=1,user=request.user)
            cart_item.save()

        # try:
        #     cart_item=CartItem.objects.get(user=request.user,variant=variant)
        #     cart_item.quantity += 1
        #     cart_item.save()
        # except:
        #     cart_item=CartItem.objects.create(variant=variant,quantity=1,user=request.user)
        #     cart_item.save()
        
        return redirect('cart')
    else:
        try:
            cart=Cart.objects.get(cart_id=_cart_id(request))
        except Cart.DoesNotExist:
            cart=Cart.objects.create(
                cart_id=_cart_id(request)
            )
            cart.save()

        try:
            cart_item=CartItem.objects.get(cart_id=cart,variant=variant)
            cart_item.quantity += 1
            cart_item.save()
        except:
            cart_item=CartItem.objects.create(
                variant=variant,
                quantity=1,
                cart_id=cart
            )
            cart_item.save()
        
        return redirect('cart')


def decrement_quantity(request,variant_id):
    
    variant=get_object_or_404(Variant,id=variant_id)
    
    try:
        if request.user.is_authenticated:
            cart_item=CartItem.objects.get(variant=variant_id,user=request.user)
            
        else:
            cart=Cart.objects.get(cart_id=_cart_id(request))
            cart_item=CartItem.objects.get(variant=variant_id,cart_id=cart)
            
        
        if cart_item.quantity > 1:
            cart_item.quantity -= 1
            cart_item.save()
        else:
            cart_item.delete()
        
    except:
        pass
    return redirect('cart')

def remove_cart_item(request,variant_id):
    
    
    variant=get_object_or_404(Variant,id=variant_id)

    if request.user.is_authenticated:
        cart_item=CartItem.objects.get(variant=variant_id,user=request.user)
    else:
        cart=Cart.objects.get(cart_id=_cart_id(request))
        cart_item=CartItem.objects.get(variant=variant_id,cart_id=cart)


    
    cart_item.delete()
    return redirect('cart')

def cart(request,total_price=0,booking_price=0,total_quantity=0):
    if request.session.has_key('buy_now_variant_id'):
        del request.session['buy_now_variant_id']
    print("cart called--------->>>>>>>>>")
    try:
        if request.user.is_authenticated:
            cart_items=CartItem.objects.filter(user=request.user,is_active=True)
            print(cart_items)
        else:
            cart=Cart.objects.get(cart_id=_cart_id(request))
            print("cart line 1 working...")
            cart_items=CartItem.objects.filter(cart_id__cart_id=_cart_id(request),is_active=True)
            

        
        print("cart line 2 working...")
        i=0
        for cart_item in cart_items:
            print("------------")
            print(cart_item.variant.get_price())
            print(cart_item.quantity)
            
            try:
                total_price += cart_item.variant.get_price()*cart_item.quantity
                
            except:
                
                total_price += cart_item.variant.price*cart_item.quantity
               

            print(total_price)
            print("------------")
            total_quantity=total_quantity+cart_item.quantity
            booking_price=booking_price+cart_item.variant.vehicle_id.category.bookingprice.booking_price*cart_item.quantity
            


                
        total_tax=booking_price*0.05
        grand_total=total_tax+booking_price
        
        request.session['pending_price']=total_price
        
        request.session['booking_price']=booking_price
        request.session['coupon_discount_price']=0
        request.session['total_tax']=total_tax
        request.session['grand_total']=grand_total

        print("cart line 3 working...")

    
    except :
        pass
    print("cart called------last--->>>>>>>>>")
    print(total_price)
    context={
        'total_price':total_price,
        'total_quantity':total_quantity,
        'cart_items':cart_items,
        'booking_price':booking_price,
        'total_tax':total_tax,
        'grand_total':grand_total


    }
    print(total_price)
    
    

    return render(request, 'cart.html',context)

@login_required(login_url='login')
def checkout(request):
    user=Account.objects.get(email=request.user)
    
        
    
    if request.user.is_authenticated:
        if request.session.has_key('buy_now_variant_id'):
            variant=Variant.objects.get(id=request.session['buy_now_variant_id'])
            booking_price=BookingPrice.objects.get(category=variant.vehicle_id.category).booking_price
            request.session['pending_price']=int(variant.get_price())
            request.session['booking_price']=booking_price
        else:
            cart_items=CartItem.objects.filter(user=request.user,is_active=True)
            booking_price=request.session['booking_price']
    else:
        cart=Cart.objects.get(cart_id=_cart_id(request))
        
        cart_items=CartItem.objects.filter(cart_id__cart_id=_cart_id(request),is_active=True)
        booking_price=request.session['booking_price']

        
    

    
    
    if request.session.has_key('coupon_discount_perc'):
        
        try:
            coupon=Coupon.objects.get(id=request.session['coupon_id'])
            
            user=Account.objects.get(email=request.user)
            try:
                redeemed_coupon=RedeemedCoupon.objects.get(user=user,coupon=coupon)
            except:
                redeem_coupon=None
            
            if redeem_coupon is None:
                if Coupon.objects.get(id=request.session['coupon_id']).is_active:

                    coupon_discount_perc=request.session['coupon_discount_perc']
                    coupon_discount_price=booking_price*(coupon_discount_perc)/100
                    request.session['coupon_discount_price']=coupon_discount_price
                else:
                    print("This coupon is expired")
                    coupon_discount_price=0
                    messages.Error(request,"This coupon is expired")

            else:
                coupon_discount_price=0
                messages.Error(request,"You have reedemed this coupon before")
        except:
            messages.Error(request,"Coupon not valid")
            coupon_discount_price=0
    else:
        coupon_discount_price=0
    addresses   =   Address.objects.filter(user=user)

    if request.session.has_key('buy_now_variant_id'):
        total_tax=booking_price*0.05
        
        grand_total=booking_price+total_tax
        print("*********************************************")
        grand_total-=coupon_discount_price
        print(grand_total)
        request.session['coupon_discount_price']=coupon_discount_price
        request.session['grand_total']=grand_total
        request.session['total_tax']=total_tax
        try:

            address =   Address.objects.get(user=user,default=True)
            context={

            'variant':variant,
            'booking_price':booking_price,
            'grand_total':grand_total,
            'total_tax':total_tax,
            'addresses':addresses,
            'coupon_discount_price':coupon_discount_price,
            'address':address,

            }
            
        except:
            
            context={

                'variant':variant,
                'booking_price':booking_price,
                'grand_total':grand_total,
                'total_tax':total_tax,
                'addresses':addresses,
                'coupon_discount_price':coupon_discount_price
                

                }
    else:

        total_tax=request.session['total_tax']
        grand_total=booking_price+total_tax
        print("*********************************************")
        grand_total-=coupon_discount_price
        print(grand_total)
        request.session['coupon_discount_price']=coupon_discount_price
        request.session['grand_total']=grand_total
        request.session['total_tax']=total_tax

        
        try:

            address =   Address.objects.get(user=user,default=True)
            context={

            'cart_items':cart_items,
            'booking_price':booking_price,
            'grand_total':grand_total,
            'total_tax':total_tax,
            'addresses':addresses,
            'coupon_discount_price':coupon_discount_price,
            'address':address,

            }
            
        except:
            
            context={

                'cart_items':cart_items,
                'booking_price':booking_price,
                'grand_total':grand_total,
                'total_tax':total_tax,
                'addresses':addresses,
                'coupon_discount_price':coupon_discount_price
                

                }
    
    return render(request,'place-order.html',context)

def buy_now(request,variant_id):
    user=request.user
    if user.is_authenticated:
        try:
            del request.session['coupon_id']
            del request.session['code']
            del request.session['coupon_discount_perc']
            del request.session['discount_price']
        except:
            pass
        variant=Variant.objects.get(id=variant_id)
        

        request.session['buy_now_variant_id']=variant_id
    return redirect('checkout')