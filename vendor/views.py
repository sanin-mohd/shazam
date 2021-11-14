from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from . models import Vendor
from user.models import Account
from django.contrib import messages,auth
from django.contrib.auth.decorators import login_required
from check_code import check_code
from send_code import send_code
import time
# Create your views here.

def vendor_dashboard(request):
    if request.user.is_authenticated:
        if request.user.is_staff:
            vendor=Vendor.objects.get(email=request.user)
            request.session['mobile']=vendor.mobile
            print('mobile-verified:'+str(vendor.is_mobile_verified))
            return render(request,'vendor/index.html',{'vendor':vendor})
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

        
    if request.method=="POST":
        email=request.POST['email']
        password=request.POST['password']
        user=auth.authenticate(email=email,password=password)

        
        print(user)
        if user is not None:
            if user.is_staff:
                
                vendor=Vendor.objects.get(email=email)

                print(vendor)
                if vendor.is_active:
                    request.session['mobile']=vendor.mobile
                    auth.login(request,user)
                    print("Session created")
                    return redirect('vendor')
                else:
                    messages.info(request,"You are blocked by admin")
                    print("You are blocked by admin")
                    return redirect('vendor-login')


                
            else:
                return redirect('home')
            
            

            
        else:
            print("vendor not found")
    return render(request,'vendor/login.html')

def vendor_logout(request):
        auth.logout(request)
        print('session deleted')
        return redirect('vendor-login')
    
        
    

def vendor_register(request):
    if request.method=='POST':
        vendor_name=request.POST['vendor_name']
        GST_number=request.POST['GST_number']
        email=request.POST['email']
        password=request.POST['password']
        confirm_password=request.POST['confirm_password']
        mobile=request.POST['mobile']
        logo=request.FILES.get('logo')

        if(confirm_password==password):

            vendor=Vendor.objects.create(vendor_name=vendor_name,GST_number=GST_number,email=email,mobile=mobile,logo=logo)
            
            vendor.save()
            user=Account.objects.create_vendor(email=email,password=password)
            auth.login(request,user)


            print("vendor created")
            request.session['mobile']=mobile
            return redirect('vendor')
        else:
            print("Password not matching")

    return render(request,'vendor/register.html')

def otp(request):
    if request.method=="POST":
        entered_code=str(request.POST['first'])+str(request.POST['second'])+str(request.POST['third'])+str(request.POST['fourth'])
        mobile=request.session['mobile']
        if check_code(mobile,entered_code):
            user=Vendor.objects.get(mobile=mobile)
            user.is_mobile_verified=True
            user.save()
            auth.login(request,user)
            return redirect('vendor')
        else:
            messages.info(request,"OTP not matching...")
            return redirect('vendor-otp')

    else:
        mobile=request.session['mobile']
        
        send_code(mobile)
        time.sleep(5)
        print("OTP sent----->>>>")
        return render(request,'vendor/otp.html',{'mobile':mobile})
