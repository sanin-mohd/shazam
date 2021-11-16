from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.utils.text import slugify

# local Django
from .models import Category


@receiver(pre_save, sender=Category)
def category_slug(sender, instance, *args, **kwargs):
    instance.slug = slugify(instance.category_name)