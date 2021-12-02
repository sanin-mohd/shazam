
from django.utils import timezone
from django.db.models.aggregates import Sum
from django.db.models.query import RawQuerySet
from django.http import request
from django.http.response import JsonResponse
from django.shortcuts import redirect, render
from orders.models import OrderVehicle,Order
from superadmin.models import BookingPrice
from vendor.models import Vendor
from user.models import Account
from django.contrib import messages, auth
from django.views.decorators.cache import never_cache
from . verify_sms import verify_sms
from category.models import Category
from category.forms import CategoryForm
# Create your views here.
from django.contrib.auth.decorators import user_passes_test
# Create your views here.
from datetime import date
from datetime import timedelta
from showroom.models import Vehicle,Variant


def superadmin_login(request):
    if request.method == "POST":
        username = request.POST['username']
        password = request.POST['password']
        if (username == 'admin' and password == 'admin'):
            request.session['admin'] = 'admin'
            print("admin logged in")
            return redirect('superadmin')
    if request.session.has_key('admin'):
        return redirect('superadmin')
    else:
        return render(request, 'superadmin/login.html')


def superadmin_logout(request):
    if request.session.has_key('admin'):
        # del request.session['admin']
        auth.logout(request)
        return redirect('superadmin-login')


@never_cache
def superadmin_dashboard(request):
    if request.session.has_key('admin'):
        month = timezone.now().month
        

        #monthly booking count
        booking_count=OrderVehicle.objects.filter(created_at__month=month).aggregate(Sum('quantity'))
        print(booking_count)
        #best seller
        
        #total no of seller
        seller_count=Vendor.objects.all().count()
        #total no of custmers
        customer_count=Account.objects.filter(is_staff=False).count()
        # %growth of customers in week
        today   = date.today()
        tommorrow=today+timedelta(1)
        yesterday=today-timedelta(1)
        today_7 = today - timedelta(days=7)
        #weekly
        new_customer_count      =   Account.objects.filter(is_staff=False,date_joined__range=[tommorrow,today_7]).count()
        old_customer_count      =   Account.objects.filter(is_staff=False,date_joined__lte=today_7).count()
        print(old_customer_count)
        print('fds')
        try:

            new_customer_count_perc = ((old_customer_count-new_customer_count)/old_customer_count)*100
        except:
            new_customer_count_perc=0
        #monthly revenue 
        total_revenue           =   Order.objects.filter(created_at__month=month).aggregate(Sum('order_total'))
        today_new_orders        =   Order.objects.filter(created_at__range=[today,tommorrow])
        yesterday_orders        =   Order.objects.filter(created_at__range=[yesterday,today])
        
        today_revenue=0
        
        for x in today_new_orders:
            today_revenue+=x.order_total

        yesterday_revenue=0

        for x in yesterday_orders:
            yesterday_revenue+=x.order_total

        
        
        
        print(total_revenue)
        print(today_new_orders)
        print(yesterday_orders)
        print("-------------------------------")
        
        new_total_revenue_perc  =   ((today_revenue-yesterday_revenue)/ yesterday_revenue)*100  
        #Monthly data for vehicle sales by vehicle_name chart
        chart2labels    =   []
        chart2data      =   []
        vehicle_orders  =   OrderVehicle.objects.filter(ordered=True,created_at__month=month)
        for vehicle_order in vehicle_orders:
            if vehicle_order.vehicle.vehicle_name in chart2labels:
                i=chart2labels.index(vehicle_order.vehicle.vehicle_name)
                chart2data[i]+=vehicle_order.quantity
            else:
                chart2labels.append(vehicle_order.vehicle.vehicle_name)
                chart2data.append(vehicle_order.quantity)
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print(chart2labels)
        print(chart2data)
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        #totatl vehicles
        vehicle_count=Vehicle.objects.all().count()
        #Monthly Best selling vehicle

            
        try:
            best_booking_vehicle=chart2labels[chart2data.index(max(chart2data))]
            best_booking_count=max(chart2data)
        except:
            best_booking_vehicle=None
            best_booking_count=0

        #daily bookings
        today = date.today()
        tommorrow=today+timedelta(1)
            
        today_1 = today - timedelta(days=1)
        today_2 = today - timedelta(days=2)
        today_3 = today - timedelta(days=3)
        today_4 = today - timedelta(days=4)
        today_5 = today - timedelta(days=5)
        today_6 = today - timedelta(days=6)
        today_7 = today - timedelta(days=7)
        print(today)
        print(tommorrow)
        print("---------------------------------------------")
        last_week_days=[

            today_6.strftime("%a %m/%d/%Y"),
            today_5.strftime("%a %m/%d/%Y"),
            today_4.strftime("%a %m/%d/%Y"),
            today_3.strftime("%a %m/%d/%Y"),
            today_2.strftime("%a %m/%d/%Y"),
            today_1.strftime("%a %m/%d/%Y"),
            today.strftime("%a %m/%d/%Y"),
                
            ]
            

            
        today_bookings      =   OrderVehicle.objects.filter(created_at__range=[today,tommorrow]).count()
        today_1_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_1,today]).count()
        today_2_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_2,today_1]).count()
        today_3_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_3,today_2]).count()
        today_4_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_4,today_3]).count()
        today_5_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_5,today_4]).count()
        today_6_bookings    =   OrderVehicle.objects.filter(created_at__range=[today_6,today_5]).count()

        lastweek_bookings   =   [today_6_bookings,today_5_bookings,today_4_bookings,today_3_bookings,today_2_bookings,today_1_bookings,today_bookings]



        context={
            'total_revenue':total_revenue,
            'booking_count':booking_count,
            'seller_count':seller_count,
            'customer_count':customer_count,
            'new_customer_count_perc':new_customer_count_perc,
            'new_total_revenue_perc':new_total_revenue_perc,
            'best_booking_vehicle':best_booking_vehicle,
            'vehicle_count':vehicle_count,
            'last_week_days':last_week_days,
            'lastweek_bookings':lastweek_bookings,
            'chart2labels':chart2labels,
            'chart2data':chart2data,



        }
        return render(request, 'superadmin/dashboard.html',context)
    else:
        return redirect('superadmin-login')


def vendor_list(request):
    if request.session.has_key('admin'):
        vendors = Vendor.objects.all()
        return render(request, 'superadmin/vendor.html', {'vendors': vendors})
    else:
        return redirect('superadmin')


def vendor_list_for_verification(request):
    if request.session.has_key('admin'):
        vendors = Vendor.objects.filter(is_verified=False)

        return render(request, 'superadmin/vendor.html', {'vendors': vendors, 'pending': 1})
    else:
        return redirect('superadmin')


def active_vendor_list(request):
    if request.session.has_key('admin'):
        vendors = Vendor.objects.filter(is_verified=True)

        return render(request, 'superadmin/vendor.html', {'vendors': vendors, 'pending': 0})
    else:
        return redirect('superadmin')


def customer_list(request):
    if request.session.has_key('admin'):
        customers = Account.objects.filter(is_staff=False)
        return render(request, 'superadmin/customer.html', {'customers': customers})
    else:
        return redirect('superadmin')


def block_vendor(request, pk):
    admin_check(request)
    vendor = Vendor.objects.get(id=pk)
    vendor.is_active = False
    vendor.save()
    print('vendor blocked')
    return redirect('active-vendor-list')


def unblock_vendor(request, pk):
    admin_check(request)
    vendor = Vendor.objects.get(id=pk)
    vendor.is_active = True
    vendor.save()
    print('vendor unblocked')
    return redirect('active-vendor-list')


def delete_vendor(request, pk):
    admin_check(request)
    if request.is_ajax():
        Vendor.objects.get(id=pk).delete()
        return JsonResponse({'message': 'success'})
        print('ajax :vendor deleted')

    vendor = Vendor.objects.get(id=pk)
    vendor.delete()

    print('vendor deleted')
    return redirect('active-vendor-list')


def block_customer(request, pk):
    admin_check(request)
    customer = Account.objects.get(id=pk)
    customer.is_active = False
    customer.save()
    print('customer blocked')
    return redirect('customer-list')


def unblock_customer(request, pk):
    admin_check(request)
    customer = Account.objects.get(id=pk)
    customer.is_active = True
    customer.save()
    print('customer unblocked')
    return redirect('customer-list')


def verify_vendor(request, pk):
    admin_check(request)
    if request.is_ajax():
        vendor = Vendor.objects.get(id=pk)
        vendor.is_verified = True
        vendor.save()
        mobile = vendor.mobile
        # verify_sms(mobile)

        return JsonResponse({'message': 'success'})
        print('ajax :vendor Verified')

    vendor = Vendor.objects.get(id=pk)
    vendor.is_verified = True
    vendor.save()
    mobile = vendor.mobile
    verify_sms(mobile)

    return redirect('vendor-list-for-verification')

    


def admin_check(request):
    if request.session.has_key('admin'):
        pass
    else:
        redirect('superadmin-login')



def view_Categories(request):
    categories=Category.objects.all()
    for x in categories:
        print(x.category_name)
    context={'categories':categories}
    print(context)
    return render(request,'superadmin/view_categories.html',context)



def add_Category(request):
    admin_check(request)


    if request.method == 'POST':
        category_name=request.POST['category']
        gif=request.POST['gif']

        category=Category.objects.create(category_name=category_name,gif=gif)
        category.save()

        messages.success(request, 'Successfully added new brand')
        return redirect('view-categories')

    return render(request, 'superadmin/add_categories.html')



      
def edit_category(request,pk):
    admin_check(request)
    if request.method=="POST":
        category_name=request.POST["category_name"]
        gif=request.POST["gif"]
        try:

            category=Category.objects.get(id=pk)
            category.category_name=category_name
            category.gif=gif
            category.save()
            return redirect('view-categories')
        except:
            messages.info(request,"Not a valid data")
            return redirect('edit-category')


    else:
        category=Category.objects.get(id=pk)
        return render(request,'superadmin/edit_category.html',{'category':category})

 
def delete_category(request,pk):
    print('category deleted-------------->>>>>>>>>>')
    Category.objects.get(id=pk).delete()
    return redirect('view-categories')

#Booking Price

def price_table(request):
    bookingprices=BookingPrice.objects.all()
    context={
        'bookingprices':bookingprices,
    }
    return render(request,'superadmin/price_table.html',context)
def add_price(request):
    if request.method=="POST":
        category_id=request.POST['category']
        booking_price=request.POST['booking_price']
        category=Category.objects.get(id=category_id)

        try:
            BookingPrice.objects.create(category=category,booking_price=booking_price)
        except:
            messages.error(request,"Booking Price already entered for the category")
            return redirect('add_price')
        return redirect('price_table')
    categories=Category.objects.all()
    context={

        'categories':categories,
    }
    return render(request,'superadmin/add_price.html',context)
def edit_price(request,id):
    if request.method=="POST":
        
        booking_price=request.POST['booking_price']
        

        try:
            bookingprice=BookingPrice.objects.get(id=id)
            bookingprice.booking_price=booking_price
            bookingprice.save()
        except:
            messages.error(request,"Something went Wrong")
            return redirect('edit_price',id)
        return redirect('price_table')
    bookingprice=BookingPrice.objects.get(id=id)
    context={

        'bookingprice':bookingprice,
    }
    return render(request,'superadmin/edit_price.html',context)