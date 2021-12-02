from django.http.response import HttpResponse
from django.shortcuts import redirect, render

from orders.models import Order, OrderVehicle
from . models import Vendor
from user.models import Account
from django.contrib import messages, auth
from django.contrib.auth.decorators import login_required
from check_code import check_code
from send_code import send_code
import time
from django.contrib.auth.decorators import user_passes_test
from showroom.models import Vehicle,Variant
from category.models import Category
from django.db.models import Sum
from django.utils import timezone

from datetime import date
from datetime import timedelta
from django.db.models import Q

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def vendor_dashboard(request):
    if request.user.is_authenticated:
        if request.user.is_staff:
            vendor = Vendor.objects.get(email=request.user)
            request.session['mobile'] = vendor.mobile
            print('mobile-verified:'+str(vendor.is_mobile_verified))
            month = timezone.now().month
            #Monthly bookings details
            booking         =   OrderVehicle.objects.filter(vendor=vendor,created_at__month=month)
            completed       =   OrderVehicle.objects.filter(vendor=vendor,status='Completed',created_at__month=month).count()
            total_booking   =   booking.count()
            pending         =   OrderVehicle.objects.filter( vendor=vendor,created_at__month=month)
            pending_count=0
            for x in pending:
                if x.status=="Offline verification Pending" or x.status=='Delivery in Process':
                    pending_count+=x.quantity
            # (Q(status ='Offline verification Pending' ) or Q(status ='Delivery in Process' ))
            pending=pending_count
            print(pending)
            print('tefffsfsfdfs')
            cancelled       =   OrderVehicle.objects.filter(vendor=vendor,status='Cancelled',created_at__month=month).count()
            try:

                completed_perc  =   completed*100/total_booking
                pending_perc    =   pending*100/total_booking 
                cancelled_perc  =   cancelled*100/total_booking
            except:
                completed_perc=0
                pending_perc=0
                cancelled_perc=0
            
            #Monthly Revenue data 
            recieved_revenue=   OrderVehicle.objects.filter(vendor=vendor,status='Completed',created_at__month=month).aggregate(Sum('price'))
            print("Recieved Revenue : ")
            print(recieved_revenue)
            max_revenue     =   OrderVehicle.objects.filter(vendor=vendor,created_at__month=month).aggregate(Sum('price'))
            print("MAX Revenue : ")
            print(max_revenue)
            inventory=0
            inventory_revenue=  OrderVehicle.objects.filter(vendor=vendor,created_at__month=month)
            for x in inventory_revenue:
                if x.status=="Offline verification Pending" or x.status=='Delivery in Process':
                    inventory+=x.price
            inventory_revenue=inventory
            print("Inventory Revenue : ")
            print(inventory_revenue)
            #Monthly data for vehicle sales by vehicle_name chart
            chart2labels    =   []
            chart2data      =   []
            vehicle_orders  =   OrderVehicle.objects.filter(vendor=vendor,ordered=True,created_at__month=month)
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
            

            
            today_bookings      =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today,tommorrow]).count()
            today_1_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_1,today]).count()
            today_2_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_2,today_1]).count()
            today_3_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_3,today_2]).count()
            today_4_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_4,today_3]).count()
            today_5_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_5,today_4]).count()
            today_6_bookings    =   OrderVehicle.objects.filter(vendor=vendor,created_at__range=[today_6,today_5]).count()

            lastweek_bookings=[today_6_bookings,today_5_bookings,today_4_bookings,today_3_bookings,today_2_bookings,today_1_bookings,today_bookings]


            context={
                'vendor':vendor,

                #Monthly bookings details
                'total_booking':total_booking,
                'completed':completed,
                'pending':pending,
                'cancelled':cancelled,
                'completed_perc':completed_perc,
                'cancelled_perc':cancelled_perc,
                'pending_perc':pending_perc,
                'inventory_revenue':inventory_revenue,

                #Monthly Revenue data 
                'max_revenue':max_revenue,
                'recieved_revenue':recieved_revenue,

                #Monthly Best selling vehicle
                'best_booking_vehicle':best_booking_vehicle,
                'best_booking_count':best_booking_count,

                #Monthly data for vehicle sales by vehicle_name chart
                'chart2labels':chart2labels,
                'chart2data':chart2data,
                
                #weekly_booking
                'last_week_days':last_week_days,
                'lastweek_bookings':lastweek_bookings,

            }
            return render(request, 'vendor/dashboard.html', context)
        else:
            auth.logout(request)
            return redirect('home')
    return redirect('vendor-login')


def vendor_login(request):
    if request.user.is_authenticated:
        if request.user.is_staff:
            return redirect('vendor')
        else:
            print("you are not staff.. please register first")
            return redirect('home')

    if request.method == "POST":
        email = request.POST['email']
        password = request.POST['password']
        user = auth.authenticate(email=email, password=password)

        print(user)
        if user is not None:
            if user.is_staff:

                vendor = Vendor.objects.get(email=email)

                print(vendor)
                if vendor.is_active:
                    request.session['mobile'] = vendor.mobile
                    auth.login(request, user)
                    print("Session created")
                    return redirect('vendor')
                else:
                    messages.info(request, "You are blocked by admin")
                    print("You are blocked by admin")
                    return redirect('vendor-login')

            else:
                return redirect('home')

        else:
            print("vendor not found")
    return render(request, 'vendor/login.html')

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def vendor_logout(request):
    auth.logout(request)
    print('session deleted')
    return redirect('vendor-login')


def vendor_register(request):
    if request.method == 'POST':
        vendor_name = request.POST['vendor_name']
        GST_number = request.POST['GST_number']
        email = request.POST['email']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']
        mobile = request.POST['mobile']
        logo = request.FILES.get('logo')

        if(confirm_password == password):
            try:
                vendor = Vendor.objects.create(
                    vendor_name=vendor_name, GST_number=GST_number, email=email, mobile=mobile, logo=logo)

                vendor.save()
                user = Account.objects.create_vendor(
                    email=email, password=password)
                auth.login(request, user)

                print("vendor created")
                request.session['mobile'] = mobile
                return redirect('vendor')
            except:
                messages.success(request,'Account already exists..')
                return redirect('vendor-register')
        else:
            print("Password not matching")

    return render(request, 'vendor/register.html')

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def otp(request):
    if request.method == "POST":
        entered_code = str(request.POST['first'])+str(request.POST['second'])+str(
            request.POST['third'])+str(request.POST['fourth'])
        mobile = request.session['mobile']
        if check_code(mobile, entered_code):
            user = Vendor.objects.get(mobile=mobile)
            user.is_mobile_verified = True
            user.save()
            user = auth.authenticate(email=user.email, password=user.password)
            auth.login(request, user)
            return redirect('vendor')
        else:
            messages.info(request, "OTP not matching...")
            return redirect('vendor-otp')

    else:
        mobile = request.session['mobile']

        send_code(mobile)
        
        print("OTP sent----->>>>")
        return render(request, 'vendor/otp.html', {'mobile': mobile})


@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def view_vehicles(request):

    

    vendor=Vendor.objects.get(email=request.user.email)
    vehicles=Vehicle.objects.filter(vendor_id=vendor.id)
    return render(request,'vendor/view_vehicles.html',{'vehicles':vehicles,'vendor':vendor})
    
@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def add_vehicle(request):
    if request.method=="POST":
        print("add vehicle post request")
        vehicle_name=request.POST['vehicle_name']
        range=request.POST['range']
        category_name=request.POST['category']
        
        top_speed=request.POST['top_speed']
        no_of_seats=request.POST['no_of_seats']
        gif=request.POST['gif']
        email=request.user
        vendor=Vendor.objects.get(email=email)

        vehicle=Vehicle.objects.create(vendor_id=vendor,vehicle_name=vehicle_name,category=Category.objects.get(category_name=category_name),range=range,top_speed=top_speed,no_of_seats=no_of_seats,gif=gif)
        vehicle.save()
        return redirect('view-vehicles')
    else:
        categories=Category.objects.all()
        vendor=Vendor.objects.get(email=request.user.email)
        return render(request,'vendor/add_vehicle.html',{'vendor':vendor,'categories':categories})

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def edit_vehicle(request,pk):
    if request.method=="POST":
        print("edit vehicle post request")
        vehicle_name=request.POST['vehicle_name']
        range=request.POST['range']
        category_name=request.POST['category']
        top_speed=request.POST['top_speed']
        no_of_seats=request.POST['no_of_seats']
        gif=request.POST['gif']
        try:

            vehicle=Vehicle.objects.get(id=pk)
            vehicle.vehicle_name=vehicle_name
            vehicle.category_name=category_name
            vehicle.range=range
            vehicle.top_speed=top_speed
            vehicle.no_of_seats=no_of_seats
            vehicle.gif=gif
            vehicle.save()
            return redirect('view-vehicles')

        except:
            messages.info(request,"Not a valid data")
            return redirect('edit-category')

        

    else:
        vendor=Vendor.objects.get(email=request.user.email)
        vehicle=Vehicle.objects.get(id=pk,vendor_id=vendor)
        categories=Category.objects.all()
        return render(request,'vendor/edit_vehicle.html',{'vehicle':vehicle,'categories':categories,'vendor':vendor})
    


@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def delete_vehicle(request,pk):

    Vehicle.objects.get(id=pk).delete()
    return redirect('view-vehicles')

def view_variants(request,pk):
    vendor=Vendor.objects.get(email=request.user.email)
    try:

        vehicle=Vehicle.objects.get(id=pk,vendor_id=vendor)
        variants=Variant.objects.filter(vehicle_id=vehicle)
        vendor=Vendor.objects.get(email=request.user)
        return render(request,'vendor/view_variants.html',{'vehicle':vehicle,'variants':variants,'vendor':vendor})
    except:
        print("No variants to display----------->>>>>>>>>>>>")
        return redirect('view-vehicles',pk)

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def add_variant(request,pk):
    vehicle=Vehicle.objects.get(id=pk)
    if request.method=="POST":
        color=request.POST['color']
        price=request.POST['price']
        remaining=request.POST['remaining']
        image1=request.FILES.get('image1')
        image2=request.FILES.get('image2')
        image3=request.FILES.get('image3')
        try:
            variant=Variant.objects.create(vehicle_id=vehicle,color=color,price=price,image1=image1,image2=image2,image3=image3,remaining=remaining)
            variant.save()
            return redirect('view-variants',pk)
        except:
            messages.info(request,"Data Not valid")
            print("Data not valid")
            return redirect('add-variant', pk)

        
    else:
        
        vendor=Vendor.objects.get(email=request.user.email)
        return render(request,'vendor/add_variant.html',{'vendor':vendor,'vehicle':vehicle})
@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def edit_variant(request,pk):
    variant=Variant.objects.get(id=pk)
    if request.method=="POST":
        color=request.POST['color']
        price=request.POST['price']
        remaining=request.POST['remaining']
        image1=request.FILES.get('image1')
        image2=request.FILES.get('image2')
        image3=request.FILES.get('image3')
        try:
            variant.color=color
            variant.price=price
            variant.remaining=remaining
            if image1 is not None:
                variant.image1=image1
            if image2 is not None:
                variant.image2=image2
            
            if image3 is not None:
                variant.image3=image3
            
            variant.save()
            pk=variant.vehicle_id.id
            return redirect('view-variants',pk)
        except:
            messages.info(request,"Data Not valid")
            print("Data not valid")
            return redirect('edit-variant', pk)

        
    else:
        
        vendor=Vendor.objects.get(email=request.user.email)
        vehicle=Vehicle.objects.get(id=variant.vehicle_id.id)
        
        return render(request,'vendor/edit_variant.html',{'vendor':vendor,'variant':variant,'vehicle':vehicle})
    
@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def delete_variant(request,pk):
    try:
        
        variant=Variant.objects.get(id=pk)
        vehicle_id=variant.vehicle_id.id
        variant.delete()
        
        print("variant deleted ")
        return redirect('view-variants',vehicle_id)
    except:
        messages.info("Somthing went wrong")
        return redirect('edit-variant',pk)

def new_booking(request):
    vendor=Vendor.objects.get(email=request.user.email)
    vendor_orders=OrderVehicle.objects.filter(vendor=vendor.id, status='Offline verification Pending').order_by('-created_at')
    context={
        'vendor':vendor,
        'vendor_orders':vendor_orders,

        }
    
    return render(request,'vendor/new_booking.html',context)
def approved_booking(request):
    vendor=Vendor.objects.get(email=request.user.email)
    vendor_orders=OrderVehicle.objects.filter(vendor=vendor.id,status = 'Delivery in Process').order_by('-created_at')
    context={
        'vendor':vendor,
        'vendor_orders':vendor_orders,

        }
    
    return render(request,'vendor/approved_bookings.html',context)
def cancelled_booking(request):
    vendor=Vendor.objects.get(email=request.user.email)
    vendor_orders=OrderVehicle.objects.filter(vendor=vendor.id,status = 'Cancelled').order_by('-created_at')
    context={
        'vendor':vendor,
        'vendor_orders':vendor_orders,

        }
    
    return render(request,'vendor/cancelled_bookings.html',context)
def completed_booking(request):
    vendor=Vendor.objects.get(email=request.user.email)
    vendor_orders=OrderVehicle.objects.filter(vendor=vendor.id,status = 'Completed').order_by('-created_at')
    context={
        'vendor':vendor,
        'vendor_orders':vendor_orders,

        }
    
    return render(request,'vendor/completed_bookings.html',context)
def verify_booking(request,ordervehicle):
    ordervehicle=OrderVehicle.objects.get(id=ordervehicle)
    ordervehicle.status='Delivery in Process'
    order=Order.objects.get(id=ordervehicle.order.id)
    order.status="Delivery in Process"
    order.save()
    print(ordervehicle.status)
    ordervehicle.save()
    return redirect('new_booking')

def change_delivery_status(request,ordervehicle):
    ordervehicle=OrderVehicle.objects.get(id=ordervehicle)
    ordervehicle.status='Completed'
    ordervehicle.save()
    return redirect('new_booking')

