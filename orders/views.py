from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from cart.models import Cart,CartItem
from orders.send_sms import send_sms
from .forms import OrderForm
from showroom.models import Vehicle,Variant
from .models import Order,OrderVehicle, Payments
import datetime
import PyCurrency_Converter
import json
# Create your views here.

def book_now(request):
    user=request.user
    
    # if user cart quantity is zero ,then redirect to home

    cart_items=CartItem.objects.filter(user=user)
    cart_count=cart_items.count()
    if cart_count<=0:
        return redirect('home')
    

    if request.method=="POST":
        form=OrderForm(request.POST)
        
        grand_total=0
        booking_price=0
        grand_booking_price=0
        tax=0
        
        for cart_item in cart_items:
            grand_total += (cart_item.variant.price*cart_item.quantity)
            booking_price += (999*cart_item.quantity)
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
            print(cart_item.variant.price)
            print(cart_item.quantity)

        print(grand_total)


        tax=.05*booking_price
        grand_booking_price=booking_price+tax 
        grand_booking_total_USD=round(grand_booking_price/75) 
        pending_amount=grand_total
              

        if form.is_valid():
            
            #store all the billing informations to Order table
            data=Order()
            data.user           =   user
            data.full_name      =   request.POST.get('full_name')
            data.address_line_1 =   request.POST.get('address_line_1')
            data.address_line_2 =   request.POST.get('address_line_2')
            data.city           =   request.POST.get('city')
            data.state          =   request.POST.get('state')
            data.zip_code       =   request.POST.get('zip_code')
            data.country        =   request.POST.get('country')
            data.mobile         =   request.POST.get('mobile')
            data.landmark       =   request.POST.get('landmark')
            data.payment_option =   request.POST.get('payment_option')
            data.tax            =   tax
            data.order_total    =   booking_price
            data.pending_amount =   pending_amount
            data.ip             =   request.META.get('REMOTE_ADDR')
            
            
            data.save()

            #Generate order ID

            yr                  =   int(datetime.date.today().strftime('%Y'))
            dt                  =   int(datetime.date.today().strftime('%d'))
            mt                  =   int(datetime.date.today().strftime('%m'))
            d                   =   datetime.date(yr,mt,dt)
            current_date        =   d.strftime("%Y%m%d") #20211124
            data.order_number   =   current_date+str(data.id)
            data.save()

            order               =   Order.objects.get(user=user,is_ordered=False,order_number=data.order_number)
            if data.payment_option=="Paypal":
                paypal=1
            else:
                paypal=0
            context={
                'order':order,
                'cart_items':cart_items,
                'grand_total':grand_total,
                'booking_price':booking_price,
                'grand_booking_total':grand_booking_price,
                'grand_booking_total_USD':grand_booking_total_USD,
                'tax':tax,
                'paypal':paypal,


            }
            return render(request,'pay_now.html',context)
    else:
        return HttpResponse("not a post method")


def pay_now(request):
    

    return render(request,'pay_now.html')

def update_payment(request):
    body=json.loads(request.body)
    order=Order.objects.get(user=request.user,is_ordered=False,order_number=body['orderID'])
    print(body)
    
    #save transaction id inside payment table
    payment=Payments(
        user            =   request.user,
        payment_id      =   body['transID'],
        payment_method  =   body['payment_option'],
        amount_paid     =   order.order_total,
        status          =   body['status'],
        )
    payment.save()

    order.payment       =   payment
    order.is_ordered    =   True

    order.save()

    # Move cart items to bookings table 
    cart_items=CartItem.objects.filter(user=request.user)

    for item in cart_items:
        
        ordervehicle            =   OrderVehicle()
        ordervehicle.order      =   order
        ordervehicle.payment    =   payment
        ordervehicle.user       =   request.user
        ordervehicle.vehicle    =   item.variant.vehicle_id
        ordervehicle.variant    =   item.variant
        ordervehicle.quantity   =   item.quantity
        ordervehicle.price      =   item.variant.price
        ordervehicle.paid       =   item.quantity*999
        ordervehicle.ordered    =   True
        
        ordervehicle.save()

        # Reduce the quantity of sold variants
        variant=Variant.objects.get(id=item.variant.id)

        variant.remaining       -=   item.quantity

        variant.save()


    # Clear cart
    CartItem.objects.filter(user=request.user).delete()

    # Send booking confirmation message to user
    username    =   str(order.full_name)
    mobile      =   str(order.mobile)
    orderID     =   str(body['orderID'])
    paid        =   str(order.order_total)
    pending     =   str(order.pending_amount)


    print("order confirm message sending")
    send_sms(username,mobile,orderID,paid,pending)
    print("order confirm message sent")


    # Send order number and payment id back to sendData via JsonResponse


    return redirect('home')





