
# Django
from crispy_forms.layout import Submit
from django.forms import ModelForm

# local Django
from .models import Category
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit,Layout,Row,Column
from crispy_forms.bootstrap import FormActions
class CategoryForm(ModelForm):
    class Meta:
        model = Category
        fields = ['category_name','gif']
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs)
        self.helper=FormHelper()
        
        
