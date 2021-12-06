import django
from django.http.response import HttpResponse, JsonResponse
from django.shortcuts import redirect, render
from cart.models import Cart,CartItem
from coupons.models import Coupon, RedeemedCoupon
from orders.send_sms import send_sms
from django.conf import settings
from .forms import OrderForm
from showroom.models import Vehicle,Variant
from .models import Order,OrderVehicle, Payments
import datetime
from shazam import settings
from forex_python.converter import CurrencyRates
import json
import razorpay
client = razorpay.Client(auth=(settings.RZORPAY_API_KEY, settings.RAZORPAY_API_SECRET_KEY))
# Create your views here.

def book_now(request):
    user=request.user
    
    # if user cart quantity is zero ,then redirect to home

    cart_items=CartItem.objects.filter(user=user)
    cart_count=cart_items.count()
    if request.session.has_key('buy_now_variant_id'):
        variant=Variant.objects.get(id=request.session['buy_now_variant_id'])
        if request.method=="POST":
            form=OrderForm(request.POST)
            
            grand_total=0
            booking_price=0

            grand_booking_price=0

            tax=0
            
            
            grand_total=variant.get_price()
            booking_price =variant.vehicle_id.category.bookingprice.booking_price
                

        
    elif cart_count<=0:
        return redirect('home')
    

    elif request.method=="POST":
        form=OrderForm(request.POST)
        
        grand_total=0
        booking_price=0

        grand_booking_price=0

        tax=0
        
        for cart_item in cart_items:
            try:
                
                if cart_item.variant.vehicle_id.vehicleoffer.is_active:
                    print(cart_item.variant.get_price())
                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
                    grand_total=grand_total+(cart_item.variant.get_price())*(cart_item.quantity)
                    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
            except:
                grand_total=grand_total+cart_item.variant.price*cart_item.quantity
            booking_price += (cart_item.variant.vehicle_id.category.bookingprice.booking_price*cart_item.quantity)
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
            print(cart_item.variant.price)
            print(cart_item.quantity)

        print(grand_total)


    tax=.05*booking_price
    booking_price=request.session['booking_price']-request.session['coupon_discount_price']
    grand_booking_price=request.session['grand_total']
    c = CurrencyRates()

    rate=c.get_rate('USD', 'INR') 
    print(grand_booking_price)
    print("----------------INR----------------")
    grand_booking_total_USD= round(grand_booking_price/rate,2)
    request.session['grand_booking_total_USD']=grand_booking_total_USD
    print(grand_booking_total_USD)
    pending_amount=request.session['pending_price']
              

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
        data.discount_price =   request.session['coupon_discount_price']
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
        request.session['orderID']=data.order_number
        print("-----order----")
        order= Order.objects.get(user=user,is_ordered=False,order_number=data.order_number)
        print("-----order----")
        if data.payment_option=="Paypal":
            paypal=1
            payment_id=0
        else:
            paypal=0
                
            print(int(data.order_total+data.tax)*100)
            payment=client.order.create(dict(amount=int(data.order_total+data.tax)*100,currency="INR",payment_capture=1))
            payment_id=payment['id']
            print(order)
                
        if request.session.has_key('buy_now_variant_id'):
            print("no buy_now_variant_id")
            context={    
            'variant':variant,
            'grand_total':grand_total,
            'booking_price':booking_price,
            'order':order,
            'grand_booking_total':grand_booking_price,
            'grand_booking_total_USD':grand_booking_total_USD,
            'tax':tax,
            'paypal':paypal,
            'RZORPAY_API_KEY':settings.RZORPAY_API_KEY,
            'payment_id':payment_id,
            }
        else:
            context={
            
                
                'cart_items':cart_items,
                'grand_total':grand_total,
                'booking_price':booking_price,
                'order':order,
                'grand_booking_total':grand_booking_price,
                'grand_booking_total_USD':grand_booking_total_USD,
                'tax':tax,
                'paypal':paypal,
                'RZORPAY_API_KEY':settings.RZORPAY_API_KEY,
                'payment_id':payment_id,
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
    request.session['payment_id'] =body['transID']
    payment.save()
    if payment.status=="COMPLETED":
        try:
            user=request.user
            coupon=Coupon.objects.get(id=request.session['coupon_id'])
            RedeemedCoupon.objects.create(user=user,coupon=coupon)
            print('coupon redeemed.............!!!!!!!!!')
            del request.session['coupon_id']
            del request.session['code']
            del request.session['coupon_discount_perc']
            print('coupon sessions deleted.............!!!!!!!!!')
        except:
            pass
    order.payment       =   payment
    order.is_ordered    =   True
    order.status        =   'New'
    order.save()
    
    if request.session.has_key('buy_now_variant_id'):
        variant=Variant.objects.get(id=request.session['buy_now_variant_id'])
            
        ordervehicle            =   OrderVehicle()
        ordervehicle.order      =   order
        ordervehicle.payment    =   payment
        ordervehicle.user       =   request.user
        ordervehicle.vendor     =   variant.vehicle_id.vendor_id
        ordervehicle.vehicle    =   variant.vehicle_id
        ordervehicle.variant    =   variant
        ordervehicle.quantity   =   1
        ordervehicle.price      =   variant.get_price()
        ordervehicle.paid       =   request.session['grand_total']
            
        ordervehicle.ordered    =   True
            
        ordervehicle.save()

            # Reduce the quantity of sold variants
        

        variant.remaining       -=   1

        variant.save()

    else:
        
        # Move cart items to bookings table 
        cart_items=CartItem.objects.filter(user=request.user)

        for item in cart_items:
            
            ordervehicle            =   OrderVehicle()
            ordervehicle.order      =   order
            ordervehicle.payment    =   payment
            ordervehicle.user       =   request.user
            ordervehicle.vendor     =   item.variant.vehicle_id.vendor_id
            ordervehicle.vehicle    =   item.variant.vehicle_id
            ordervehicle.variant    =   item.variant
            ordervehicle.quantity   =   item.quantity
            ordervehicle.price      =   item.variant.get_price()*item.quantity
            ordervehicle.paid       =   item.quantity*item.variant.vehicle_id.category.bookingprice.booking_price
            
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

    data={
        'order_number'   :order.order_number,
        'payment_id'     :payment.payment_id
    }

    return JsonResponse(data)
def razorpay_payment_verification(request):
    order=Order.objects.get(user=request.user,is_ordered=False,order_number=request.session['orderID'])
    if request.method == 'POST':
        razorpay_payment_id = request.POST.get('razorpay_payment_id')
        razorpay_order_id = request.POST.get('razorpay_order_id')
        razorpay_signature = request.POST.get('razorpay_signature')

        params_dict = {

            'razorpay_order_id': razorpay_order_id,
            'razorpay_payment_id': razorpay_payment_id,
            'razorpay_signature': razorpay_signature
        }

        try:
            client.utility.verify_payment_signature(params_dict)
        except:
            return JsonResponse({'messages': 'error'})
        user=request.user
        try:

            coupon=Coupon.objects.get(id=request.session['coupon_id'])
            RedeemedCoupon.objects.create(user=user,coupon=coupon)
            print('coupon redeemed.............!!!!!!!!!')
            del request.session['coupon_id']
            del request.session['code']
            del request.session['coupon_discount_perc']
            print('coupon sessions deleted.............!!!!!!!!!')
        except:
            pass
        

        # Saving payment details
        payment = Payments.objects.create(
            user=request.user,
            payment_id=razorpay_payment_id,
            amount_paid=order.order_total,
            payment_method='razorpay',
            status=True
        )
        order.payment       =   payment
        order.is_ordered    =   True
        order.status        =   'New'
        order.save()
        request.session['payment_id'] = razorpay_payment_id
        
    cart_items=CartItem.objects.filter(user=request.user)
    for item in cart_items:
        
        ordervehicle            =   OrderVehicle()
        ordervehicle.order      =   order
        ordervehicle.payment    =   payment
        ordervehicle.user       =   request.user
        ordervehicle.vendor     =   item.variant.vehicle_id.vendor_id
        ordervehicle.vehicle    =   item.variant.vehicle_id
        ordervehicle.variant    =   item.variant
        ordervehicle.quantity   =   item.quantity
        ordervehicle.price      =   item.variant.get_price()*item.quantity
        ordervehicle.paid       =   item.quantity*item.variant.vehicle_id.category.bookingprice.booking_price
        
        ordervehicle.ordered    =   True
        
        ordervehicle.save()

        # Reduce the quantity of sold variants
        variant=Variant.objects.get(id=item.variant.id)

        variant.remaining       -=   item.quantity

        variant.save()


    # Clear cart
    CartItem.objects.filter(user=request.user).delete()

    # Send booking confirmation message to user
    # username    =   str(order.full_name)
    # mobile      =   str(order.mobile)
    # orderID     =   str(request.session['orderID'])
    # paid        =   str(order.order_total)
    # pending     =   str(order.pending_amount)
            

    return JsonResponse({'message': 'success'})


def payment_failed(request):
    return render(request, 'payment_failed.html')
def booking_reciept(request):
    try:
        del request.session['pending_price']
        del request.session['booking_price']
        del request.session['total_tax']
        del request.session['grand_total']
    except:
        pass
    order_number   =   request.session['orderID']
    payment_id     =   request.session['payment_id']

    try:
        order           =   Order.objects.get(order_number=order_number,is_ordered=True)
        ordered_vehicle_details=   OrderVehicle.objects.filter(order=order.id)
        print(ordered_vehicle_details)
        print("--------------------------")
        grand_total_paid=order.order_total+order.tax

        context         =   {

            'order':order,
            'ordered_vehicle_details':ordered_vehicle_details,
            'payment_id':payment_id,
            'grand_total_paid':grand_total_paid,
        }


        return render(request,'booking_reciept.html',context)
    except(Payments.DoesNotExist,Order.DoesNotExist):
        return redirect('home')

def old_reciept(request,order_number):
    order          =   Order.objects.get(order_number=order_number,is_ordered=True)
    payment_id     =   order.payment.payment_id

    try:
        
        ordered_vehicle_details=   OrderVehicle.objects.filter(order=order.id)
        print(ordered_vehicle_details)
        print("--------------------------")
        grand_total_paid=order.order_total+order.tax

        context         =   {

            'order':order,
            'ordered_vehicle_details':ordered_vehicle_details,
            'payment_id':payment_id,
            'grand_total_paid':grand_total_paid,
        }


        return render(request,'old_reciept.html',context)
    except(Payments.DoesNotExist,Order.DoesNotExist):
        return redirect('home')
def ordered_details(request):
    user=request.user
    orders              =   Order.objects.filter(user=user).order_by('-created_at')[:10]
    ordered_vehicles    =   OrderVehicle.objects.filter(user=user)
    context     = {
        'orders':orders,
        'ordered_vehicles':ordered_vehicles,
        
    }
    print(ordered_vehicles)
    return render(request,'user_orders.html',context)


def cancel_booking(request,order_number):
    try:
        user=request.user
        booking             =   Order.objects.get(user=user,order_number=order_number)
        booking.is_ordered  =   False
        booking.status      =   "Cancelled"
        booking.save()
        ordervehicles       =   OrderVehicle.objects.filter(user=user,order=booking)

        for ordervehicle in ordervehicles:
            ordervehicle.status = "Cancelled"
            ordervehicle.save()

        print("cancel successfully .>>>>>>>>>>>>>>>")
    except:
        print("cancel failed .>>>>>>>>>>>>>>>")
        pass
    return redirect('ordered_details')


    






