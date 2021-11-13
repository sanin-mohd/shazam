from django import forms
import django
from django.forms.widgets import PasswordInput
from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from django.contrib import messages,auth


from user.forms import RegistrationForm
from user.models import Account
from django.contrib.auth.decorators import login_required

from send_code import send_code
from check_code import check_code
# Create your views here.

def home(request):
    if request.user.is_staff or not request.user.is_active:
        auth.logout(request)

    
    return render(request,'index.html')

def login(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method=='POST':
        mobile=request.POST['mobile']
        password=request.POST['password']
        print(mobile)
        print(password)
        email=Account.objects.get(mobile=mobile).email
        user=auth.authenticate(email=email,password=password)
        print(user)
        if user is not None:
            if user.is_staff:
                print("You are a vendor")
                return redirect('vendor')
            else:
                if user.is_active:
                    if user.is_verified:
                        auth.login(request,user)
                        return redirect('home')
                    else:
                        send_code(mobile)
                        messages.info(request,"Mobile number is not verified")
                        print("Mobile number is not verified")
                        request.session['mobile']=mobile
                        return redirect('verify-otp')


                    
                    
                else:
                    messages.info(request,"You are blocked by admin")
                    print("You are blocked by admin")
                    return redirect('login')

                
                
            
        else:
            messages.error(request,'Invalid login credentials')
            return redirect('login')

    return render(request,'signin.html')


@login_required(login_url='login')
def logout(request):
    if request.user.is_authenticated:
        
        auth.logout(request)
        messages.success(request,"You are logged out.")
        return redirect('login')



def register(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method=='POST':
        form=RegistrationForm(request.POST)
        if form.is_valid():
            first_name  =form.cleaned_data['first_name']
            last_name   =form.cleaned_data['last_name']
            email       =form.cleaned_data['email']
            gender      =form.cleaned_data['gender']
            mobile      =form.cleaned_data['mobile']
            password    =form.cleaned_data['password']

            user=Account.objects.create_user(first_name=first_name,last_name=last_name,email=email,gender=gender,mobile=mobile,password=password)

            user.save()
            
            print('User Created')
            # messages.success(request,'Registration Successful')
            send_code(mobile)
            request.session['mobile']=mobile
            return redirect('send-otp')
        print('form not valid')
    else:
        form=RegistrationForm()
    context={
        'form':form,
    }
    print('welcome to registration page')
    return render(request,'register.html',context)


def verify_otp(request):
    if request.method=="POST":
        entered_code=str(request.POST['first'])+str(request.POST['second'])+str(request.POST['third'])+str(request.POST['fourth'])+str(request.POST['fifth'])+str(request.POST['sixth'])
        mobile=request.session['mobile']
        if check_code(mobile,entered_code):
            user=Account.objects.get(mobile=mobile)
            user.is_verified=True
            user.save()
            auth.login(request,user)
            return redirect('home')
        else:
            return HttpResponse("OTP not matching")

    else:
        mobile=request.session['mobile']
        return render(request,'otp.html',{'mobile':mobile})

