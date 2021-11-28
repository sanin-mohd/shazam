from django import forms
import django
from django.contrib.auth.backends import RemoteUserBackend
from django.db import models
from django.forms.widgets import PasswordInput
from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from django.contrib import messages, auth
from cart.models import CartItem
from cart.views import _cart_id
from category.models import Category
from showroom.models import Variant, Vehicle
from django.core.paginator import EmptyPage,PageNotAnInteger,Paginator
from django.contrib.sites.shortcuts import get_current_site
from django.template.loader import render_to_string, get_template
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.contrib.auth.tokens import default_token_generator
from django.core.mail import EmailMessage
from cart.models import Cart
from banners.models import Banner
from user.forms import RegistrationForm
from user.models import Account
from django.contrib.auth.decorators import login_required
from orders.models import Order
from send_code import send_code
from check_code import check_code
# Create your views here.

@login_required(login_url='login')
def user_dashboard(request):
    user=Account.objects.get(email=request.user)
    order_count=Order.objects.filter(user=request.user).count()
    
    cancelled_order_count=Order.objects.filter(user=request.user,status='Cancelled').count()
    import decimal

    decimal.getcontext().prec = 2

    
    customer_rating=decimal.Decimal(order_count-cancelled_order_count)/decimal.Decimal(order_count)
    customer_rating=customer_rating*5
    context={
        'user': user,
        'order_count':order_count,
        'cancelled_order_count':cancelled_order_count,
        'customer_rating':customer_rating,
    }
    return render(request, 'user_dashboard.html',context)
def home(request):
    # if request.user.is_staff or not request.user.is_active:
    #     auth.logout(request)
    banners=Banner.objects.all()
    categories = Category.objects.all()
    vehicles = Vehicle.objects.filter(is_available=True).order_by('-created_date')
    paginator=Paginator(vehicles,8)
    page=request.GET.get('page')
    paged_vehicles=paginator.get_page(page)
    context={
        'categories': categories,
         'vehicles': paged_vehicles,
         'banners':banners,
    }
    return render(request, 'index.html', context)


def login(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method == 'POST':
        mobile = request.POST['mobile']
        password = request.POST['password']
        print(mobile)
        print(password)
        try:

            email = Account.objects.get(mobile=mobile).email

            user = auth.authenticate(email=email, password=password)
        except:
            user = None
            pass
        print(user)
        if user is not None:
            if user.is_staff:
                print("You are a vendor")
                return redirect('vendor')
            else:
                if user.is_active:
                    try:
                        cart=Cart.objects.get(cart_id=_cart_id(request))
                        is_cart_item_exists=CartItem.objects.filter(cart_id=cart).exists()
                        
                        if is_cart_item_exists:
                            cart_items=CartItem.objects.filter(cart_id=cart)
                            cart_items_user=CartItem.objects.filter(user=user)
                            variant_list=[]
                            
                            for item in cart_items:
                                variant=item.variant
                                variant_list.append(variant)
                            
                            cart_items=CartItem.objects.filter(user=user)
                            print("Try working------>>>>>>>>>>>>>>>>>>")
                            
                            
                            ex_var_list = []
                            id = []
                            
                            for item in cart_items:
                                existing_variants=item.variant
                                ex_var_list.append(existing_variants)
                                id.append(item.id)

                            
                            for vr in variant_list:
                                if vr in ex_var_list:
                                    index=ex_var_list.index(vr)
                                    item_id=id[index]
                                    item=CartItem.objects.get(id=item_id)
                                    count=CartItem.objects.get(variant=vr,cart_id=cart).quantity
                                    item.quantity += count
                                    print(str(item.quantity)+ ': count')
                                    item.user=user
                                    item.save()
                                else:
                                    cart_items=CartItem.objects.filter(cart_id=cart)
                                    for item in cart_items:
                                        item.user=user
                                        item.save()
                            auth.login(request,user)
                            return redirect('cart')
                            

                    except:
                        print("Entered to except block ------>>>>>>>>>>>>>>>>>>")
                        pass
                    request.session['mobile'] = mobile
                    auth.login(request, user)
                    return redirect('home')
                else:
                    messages.info(request, "You are blocked by admin")
                    print("You are blocked by admin")
                    return redirect('login')

        else:
            messages.error(request, 'Invalid login credentials')
            return redirect('login')

    return render(request, 'signin.html')


@login_required(login_url='login')
def logout(request):
    if request.user.is_authenticated:

        auth.logout(request)
        messages.success(request, "You are logged out.")
        return redirect('login')


def register(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            first_name = form.cleaned_data['first_name']
            last_name = form.cleaned_data['last_name']
            email = form.cleaned_data['email']
            gender = form.cleaned_data['gender']
            mobile = form.cleaned_data['mobile']
            password = form.cleaned_data['password']
            try:
                user = Account.objects.create_user(
                    first_name=first_name, last_name=last_name, email=email, gender=gender, mobile=mobile, password=password)

                user.save()

                print('User Created')
                #messages.success(request,'Registration Successful')

                request.session['mobile'] = mobile
                return redirect('send-otp')
            except:
                messages.success(request, 'Account already exists..')
                return redirect('register')

        print('form not valid')
    else:
        form = RegistrationForm()
    context = {
        'form': form,
    }
    print('welcome to registration page')
    return render(request, 'register.html', context)


def verify_otp(request):
    if request.method == "POST":
        entered_code = str(request.POST['first'])+str(request.POST['second'])+str(
            request.POST['third'])+str(request.POST['fourth'])
        mobile = request.session['mobile']
        if check_code(mobile, entered_code):
            user = Account.objects.get(mobile=mobile)
            user.is_verified = True
            user.save()
            auth.login(request, user)
            return redirect('home')
        else:
            messages.info(request, "OTP not matching...")
            return redirect('verify-otp')

    else:
        try:
            mobile = request.session['mobile']
            print("otp sending...")
            send_code(mobile)
        except:
            print("twilio error....!!")
            pass

        return render(request, 'otp_codepen/otp.html', {'mobile': mobile})


def otp_login(request):
    if request.method == "POST":

        try:
            mobile = request.POST['mobile']
            user = Account.objects.get(mobile=mobile, is_staff=False)
        except:
            user = None
        if user is not None:
            try:
                request.session['mobile'] = mobile
                send_code(mobile)
                print("Login otp sent")
            except:
                print("twilio error....!!")
                pass
            return redirect('check-login-otp')
        else:
            messages.info(request, "Mobile number is not registered")
            print("Mobile not registrered")
            return redirect('otp-login')

    else:
        return render(request, 'otp_signin.html')


def check_login_otp(request):
    if request.method == "POST":
        otp = request.POST['otp']
        try:
            mobile = request.session['mobile']
            if check_code(mobile, otp):
                user = Account.objects.get(mobile=mobile)
                user.is_verified = True
                user.save()

                auth.login(request, user)
                return redirect('home')
        except:
            messages.info(request, "Somthing Went Wrong")
            return redirect('otp-login')
    else:
        return render(request, 'otp-check.html')


def view_category_store(request, pk=None):
    print("------------>>>>>>>>>")
    # try:
    vehicles = Vehicle.objects.filter(category=pk,is_available=True)
    if pk==None:
        vehicles_count=vehicles.count()
        categories=Category.objects.all()
        paginator=Paginator(vehicles,6)
        page=request.GET.get('page')
        paged_vehicles=paginator.get_page(page)

        return render(request, 'store.html', {'vehicles': paged_vehicles,'categories':categories,'vehicles_count':vehicles_count})


    vehicles_count=vehicles.count()
    categories=Category.objects.all()
    category_title=Category.objects.get(id=pk).category_name
    paginator=Paginator(vehicles,6)
    page=request.GET.get('page')
    paged_vehicles=paginator.get_page(page)
    return render(request, 'store.html', {'vehicles': paged_vehicles,'categories':categories,'category_title':category_title,'vehicles_count':vehicles_count})
    # except:
        # return redirect('/')
    
def showroom(request,pk):
    vehicle=Vehicle.objects.get(id=pk)
    variants=Variant.objects.filter(vehicle_id=pk,is_available=True)
    

    return render(request,'showroom.html',{'variants':variants,'vehicle':vehicle})

def showroom_variant(request,pk):
    print('showroom variant ---->>>>>>>>>>>>')
    variant=Variant.objects.get(id=pk)
    variants=Variant.objects.filter(vehicle_id=variant.vehicle_id.id)
    vehicle=Vehicle.objects.get(id=variant.vehicle_id.id)

    in_cart=CartItem.objects.filter(cart_id__cart_id=_cart_id(request),variant=pk).exists()
    
    context={
        'variant':variant,
        'variants':variants,
        'vehicle':vehicle,
        'in_cart':in_cart
        }

    return render(request,'showroom_variant.html',context)
def staff_only(request):
    return render(request, 'restricted.html')


def admin_only(request):
    return render(request, 'restricted.html')

def search(request):
    if 'keyword' in request.GET:
        vehicles_count=0
        keyword=request.GET['keyword']
        if keyword is None:
            return render('store.html')

        
        vehicles=Vehicle.objects.order_by('-created_date').filter(vehicle_name__icontains=keyword)
        vehicles_count=vehicles.count()
        context={
            'vehicles':vehicles,
            'vehicles_count':vehicles_count
        }
        return render(request,'store.html',context)
        
def password_otp(request):
    if request.method=="POST":
        otp=request.POST['otp']
        if check_code(request.user.mobile,otp):
            return redirect('new_password')
        else:
            redirect('user_dashboard')
    send_code(request.user.mobile)
    return render(request,'password_otp.html')  
def new_password(request):
    if request.method == "POST":
        password       =    request.POST['password']
        cpassword      =    request.POST['confirm_password']
        if password == cpassword:
            user=Account.objects.get(id=request.user.id)
            user.set_password(password)
            user.save()
            auth.login(request, user)
            messages.success(request,"Password Changed successfully..")
            print("password changed >>>>>>>>>>>>>>>")
            return redirect('user_dashboard')
        else:
            messages.error(request,"Password not matching... Try again")
            return redirect('new_password')
    return render(request,'new_password.html')    
# def reset_password_link(request):
#     if request.method=="POST":
#         email=request.POST['email']
#         print("<<<<<<<<<<<<11111>>>>>>>>>")
#         if email==request.user.email:
#             user=Account.objects.get(email=request.user)

#             current_site = get_current_site(request)
#             mail_subject = 'SHAZAM account : Change Password'
#             message = render_to_string('reset_password.html',{
#                 'user':user.first_name,
#                 'domain':current_site,
#                 'uid': urlsafe_base64_encode(force_bytes(user.pk)),
#                 'token': default_token_generator.make_token(user),


#             })
            
#             to_email=user.email
#             send_email=EmailMessage(mail_subject,message,to=[to_email])
#             send_email.send()
            
#             messages.success(request,"Password changed successfully")
#             return redirect('user_dashboard')
#         else:
#             messages.error(request,"Email does not matching")
#             return redirect('reset_password_link')


        
        
    
#     return render(request,'change_password.html')

        
# def reset_password(request,uidb64,token):
#     try:
#         uid=urlsafe_base64_decode(uidb64).decode()
#         user=Account._default_manager.get(pk=uid)
#     except(TypeError,ValueError,OverflowError,Account.DoesNotExist):
#         user=None
#     if user is not None and default_token_generator.check_token(user,token):
#         request.session['uid']=uid
#         messages.success(request,'please reset your password')
#         return redirect('add_new_password')
#     return HttpResponse("ok..")
# def add_new_password(request):
#     pass
