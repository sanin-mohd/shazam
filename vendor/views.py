from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from . models import Vendor
from user.models import Account
from django.contrib import messages,auth
from django.contrib.auth.decorators import login_required

# Create your views here.

def vendor_dashboard(request):
    if request.user.is_authenticated:
        if request.user.is_staff:
            return render(request,'vendor/index.html')
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
                
                vendor=Vendor.objects.filter(email=email)
                print(vendor)
                if vendor.is_active:
                    auth.login(request,user)
                    print("Session created")
                    return redirect('vendor')
                else:
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
            return redirect('vendor')
        else:
            print("Password not matching")

    return render(request,'vendor/register.html')