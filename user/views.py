from django import forms
import django
from django.forms.widgets import PasswordInput
from django.shortcuts import redirect, render
from django.contrib import messages,auth

from user.forms import RegistrationForm
from user.models import Account
from django.contrib.auth.decorators import login_required
# Create your views here.

def home(request):
    if request.user.is_staff or not request.user.is_active:
        auth.logout(request)

    
    return render(request,'index.html')

def login(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method=='POST':
        email=request.POST['email']
        password=request.POST['password']

        user=auth.authenticate(email=email,password=password)
        if user is not None:
            if user.is_staff:
                print("You are a vendor")
                return redirect('vendor')
            else:
                if user.is_active:
                    auth.login(request,user)
                    return redirect('home')
                else:
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
            auth.login(request,user)
            print('User Created')
            # messages.success(request,'Registration Successful')
            return redirect('home')
        print('form not valid')
    else:
        form=RegistrationForm()
    context={
        'form':form,
    }
    print('welcome to registration page')
    return render(request,'register.html',context)


