from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from cart.models import Cart,CartItem
from .forms import OrderForm
from .models import Order,OrderVehicle
import datetime
import PyCurrency_Converter
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





