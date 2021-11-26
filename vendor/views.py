from django.http.response import HttpResponse
from django.shortcuts import redirect, render
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

@user_passes_test(lambda u: u.is_staff,login_url='staff-only')
def vendor_dashboard(request):
    if request.user.is_authenticated:
        if request.user.is_staff:
            vendor = Vendor.objects.get(email=request.user)
            request.session['mobile'] = vendor.mobile
            print('mobile-verified:'+str(vendor.is_mobile_verified))
            return render(request, 'vendor/index.html', {'vendor': vendor})
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
    return render(request,'vendor/new_booking.html',{'vendor':vendor})
