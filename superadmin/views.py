
from django.http import request
from django.http.response import JsonResponse
from django.shortcuts import redirect, render
from vendor.models import Vendor
from user.models import Account
from django.contrib import messages,auth
from django.views.decorators.cache import never_cache
from . verify_sms import verify_sms

# Create your views here.
def superadmin_login(request):
    if request.method=="POST":
        username=request.POST['username']
        password=request.POST['password']
        if (username=='admin' and password=='admin'):
            request.session['admin']='admin'
            print("admin logged in")
            return redirect('superadmin')
    if request.session.has_key('admin'):
        return redirect('superadmin')
    else:
        return render(request,'superadmin/login.html')

def superadmin_logout(request):
    if request.session.has_key('admin'):
        # del request.session['admin']
        auth.logout(request)
        return redirect('superadmin-login')
@never_cache  
def superadmin_dashboard(request):
    if request.session.has_key('admin'):
        return render(request,'superadmin/dashboard.html')
    else:
        return redirect('superadmin-login')

def vendor_list(request):
    if request.session.has_key('admin'):
        vendors=Vendor.objects.all() 
        return render(request,'superadmin/vendor.html',{'vendors':vendors})
    else:
        return redirect('superadmin')

def vendor_list_for_verification(request):
    if request.session.has_key('admin'):
        vendors=Vendor.objects.filter(is_verified=False)


        return render(request,'superadmin/vendor.html',{'vendors':vendors,'pending':1})
    else:
        return redirect('superadmin')
def active_vendor_list(request):
    if request.session.has_key('admin'):
        vendors=Vendor.objects.filter(is_verified=True)


        return render(request,'superadmin/vendor.html',{'vendors':vendors,'pending':0})
    else:
        return redirect('superadmin')
def customer_list(request):
    if request.session.has_key('admin'):
        customers=Account.objects.filter(is_staff=False)
        return render(request,'superadmin/customer.html',{'customers':customers})
    else:
        return redirect('superadmin')
def block_vendor(request,pk):
    admin_check(request)
    vendor=Vendor.objects.get(id=pk)
    vendor.is_active=False
    vendor.save()
    print('vendor blocked')
    return redirect('active-vendor-list')
def unblock_vendor(request,pk):
    admin_check(request)
    vendor=Vendor.objects.get(id=pk)
    vendor.is_active=True
    vendor.save()
    print('vendor unblocked')
    return redirect('active-vendor-list')
def delete_vendor(request,pk):
    admin_check(request)
    if request.is_ajax():
        Vendor.objects.get(id=pk).delete()
        return JsonResponse({'message': 'success'})
        print('ajax :vendor deleted')

    vendor=Vendor.objects.get(id=pk)
    vendor.delete()
    
    print('vendor deleted')
    return redirect('active-vendor-list')
def block_customer(request,pk):
    admin_check(request)
    customer=Account.objects.get(id=pk)
    customer.is_active=False
    customer.save()
    print('customer blocked')
    return redirect('customer-list')
def unblock_customer(request,pk):
    admin_check(request)
    customer=Account.objects.get(id=pk)
    customer.is_active=True
    customer.save()
    print('customer unblocked')
    return redirect('customer-list')

def verify_vendor(request,pk):
    admin_check(request)
    if request.is_ajax():
        vendor=Vendor.objects.get(id=pk)
        vendor.is_verified=True
        vendor.save()
        mobile=vendor.mobile
        #verify_sms(mobile)

        return JsonResponse({'message': 'success'})
        print('ajax :vendor Verified')
    
    vendor=Vendor.objects.get(id=pk)
    vendor.is_verified=True
    vendor.save()
    mobile=vendor.mobile
    verify_sms(mobile)
    
    return redirect('vendor-list-for-verification')

    

def admin_check(request):
    if request.session.has_key('admin'):
        pass
    else:
        redirect('superadmin-login')
