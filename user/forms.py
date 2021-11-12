from types import ClassMethodDescriptorType
from django import forms
from django.forms import fields    
from . models import Account



class RegistrationForm(forms.ModelForm):

    password=forms.CharField(widget=forms.PasswordInput(attrs={
        'class':'form-control'
    }))
    confirm_password=forms.CharField(widget=forms.PasswordInput(attrs={
        'class':'form-control'
    }))

    class Meta:
        model=Account
        fields=['first_name','last_name','email','mobile','gender','password']
        

    def __init__(self,*args,**kwargs):
        super(RegistrationForm ,self).__init__(*args,**kwargs)

        # self.fields['first_name'].widget.attrs['placeholder']='Enter first name'
        # self.fields['gender'].widget.attrs['class']='custom-control-input'

        for field in self.fields:
            self.fields[field].widget.attrs['class']='form-control'

    def clean(self):
        cleaned_data    =super(RegistrationForm,self).clean()
        password        =cleaned_data.get('password')
        confirm_password=cleaned_data.get('confirm_password')

        if password != confirm_password:
            raise forms.ValidationError("Password does not match")  

