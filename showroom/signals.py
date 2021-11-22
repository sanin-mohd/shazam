from django.db.models.signals import pre_save
from django.dispatch import receiver
from django.utils.text import slugify

# local Django
from .models import Vehicle,Variant


@receiver(pre_save, sender=Vehicle)
def vehicle_slug(sender, instance, *args, **kwargs):
    instance.slug = slugify(instance.vehicle_name)

@receiver(pre_save, sender=Variant)
def variant_slug(sender, instance, *args, **kwargs):
    instance.slug = slugify(instance.color_name)

