
from django.http.response import HttpResponse
from django.shortcuts import render,redirect

from showroom.models import ReviewRating,Vehicle
from .forms import ReviewForm
from django.contrib import messages
# Create your views here.
def review(request,id):
    if request.method=="POST":
        try:
            review =   ReviewRating.objects.get(user__id=request.user.id,vehicle__id=id)
            form    =   ReviewForm(request.POST,instance=review)
            form.save()
            messages.success(request,'Thank you... Your review has been updated')
            return redirect('review',id)
        except ReviewRating.DoesNotExist:
            form=ReviewForm(request.POST)   
            if form.is_valid():
                data            =   ReviewRating()
                data.rating     =   form.cleaned_data['rating']
                data.subject    =   form.cleaned_data['subject']
                data.review     =   form.cleaned_data['review']
                data.vehicle_id =   id
                data.user_id    =   request.user.id
                data.ip         =   request.META.get('REMOTE_ADDR')
                data.save()
                messages.success(request,"Your review has been submitted")
                return redirect('review',id)

    else:
        vehicle=Vehicle.objects.get(id=id)
        context={
            'vehicle_id':id,
            'vehicle':vehicle,
        }
        return render(request,'review.html',context)
    