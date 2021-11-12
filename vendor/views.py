from django.shortcuts import render

# Create your views here.

def vendor_dashboard(request):
    return render(request,'vendor/index.html')


def vendor_login(request):
    return render(request,'vendor/login.html')

def vendor_logout(request):
    pass

def vendor_register(request):
    return render(request,'vendor/register.html')