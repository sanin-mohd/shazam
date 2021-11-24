from django import forms
from django.forms import fields
from .models import Order

class OrderForm(forms.Form):
    class Meta:
        model=Order
        fields=[
            'full_name',
            'address_line_1',
            'address_line_2',
            'city',
            'zip_code',
            'state',
            'country',
            'mobile',
            'landmark',
            'payment_option'
            ]