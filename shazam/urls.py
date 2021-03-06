"""shazam URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import include
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from shazam.settings import MEDIA_ROOT

urlpatterns = [
    path('admin/', admin.site.urls),
    path('vendor/',include('vendor.urls')),
    path('',include('user.urls')),
    path('superadmin/',include('superadmin.urls')),
    path('cart/',include('cart.urls')),

    #orders
    path('orders/',include('orders.urls')),
    #banners
    path('banners/',include('banners.urls')),
    #offermanagement
    path('offers/',include('offers.urls')),
    #review
    path('review/',include('showroom.urls')),
    #coupon
    path('coupon/',include('coupons.urls')),
    #testdrive
    path('testdrive/',include('testDrive.urls')),
    
]+ static(settings.MEDIA_URL,document_root=MEDIA_ROOT)
