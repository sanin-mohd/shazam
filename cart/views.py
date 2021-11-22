from django.http.response import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from category.models import Category
from showroom.models import Vehicle,Variant
from .models import Cart,CartItem
# Create your views here.

def _cart_id(request):
    cart=request.session.session_key
    if not cart:
        cart=request.session.create()
    return cart

def add_quantity(request,variant_id):

    variant=Variant.objects.get(id=variant_id)

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
    cart=Cart.objects.get(cart_id=_cart_id(request))
    variant=get_object_or_404(Variant,id=variant_id)
    cart_item=CartItem.objects.get(variant=variant_id,cart_id=cart)

    if cart_item.quantity > 1:
        cart_item.quantity -= 1
        cart_item.save()
    else:
        cart_item.delete()
    return redirect('cart')

def remove_cart_item(request,variant_id):
    cart=Cart.objects.get(cart_id=_cart_id(request))
    variant=get_object_or_404(Variant,id=variant_id)
    cart_item=CartItem.objects.get(variant=variant_id,cart_id=cart)
    cart_item.delete()
    return redirect('cart')



def cart(request,total_price=0,booking_price=0,total_quantity=0):
    print("cart called--------->>>>>>>>>")
    try:
        cart=Cart.objects.get(cart_id=_cart_id(request))
        print("cart line 1 working...")
        cart_items=CartItem.objects.filter(cart_id__cart_id=_cart_id(request),is_active=True)
        print("cart line 2 working...")
        for cart_item in cart_items:
            total_price=total_price+cart_item.variant.price*cart_item.quantity
            total_quantity=total_quantity+cart_item.quantity
            booking_price=booking_price+999*cart_item.quantity
        total_tax=booking_price*0.05
        grand_total=total_tax+booking_price
        print("cart line 3 working...")

    
    except :
        pass
    print("cart called--------->>>>>>>>>")
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


def checkout(request):
    
    
    return render(request,'place-order.html')