from django.urls import path
from django.utils.regex_helper import normalize
from . import views

urlpatterns = [
    path('staff-only',views.staff_only,name='staff-only'),
    path('admin-only',views.admin_only,name='admin-only'),
    path('',views.home,name='home'),
    path('login',views.login,name='login'),
    path('register',views.register,name='register'),
    path('logout',views.logout,name='logout'),
    path('send-otp',views.verify_otp,name='send-otp'),
    path('verify-otp',views.verify_otp,name='verify-otp'),
    path('otp-login', views.otp_login,name='otp-login'),
    path('check-login-otp',views.check_login_otp,name='check-login-otp'),
    path('view-category-store/<int:pk>',views.view_category_store,name='view-category-store'),
    path('showroom/<int:pk>',views.showroom,name='showroom'),
    path('showroom-variant/<int:pk>',views.showroom_variant,name='showroom-variant'),
    path('search',views.search,name='search'),
    path('user_dashboard',views.user_dashboard,name='user_dashboard'),
    path('password_otp',views.password_otp,name='password_otp'),
    path('new_password',views.new_password,name='new_password'),
    path('my_address',views.my_address,name='my_address'),
    path('add_address',views.add_address,name='add_address'),
    path('delete_address/<str:id>',views.delete_address,name='delete_address'),
    path('edit_address/<str:id>',views.edit_address,name='edit_address'),
    path('set_default/<str:id>',views.set_default,name='set_default'),
    path('set_default2/<str:id>',views.set_default2,name='set_default2')



    # path('change_password',views.reset_password_link,name='change_password'),
    # path('reset_password/<uidb64>/<token>/',views.reset_password,name='reset_password'),
    # path('add_new_password',views.add_new_password,name='add_new_password'),





    



]