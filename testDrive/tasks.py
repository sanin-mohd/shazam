# Create your tasks here

from testDrive.models import Slots
import datetime
from celery import shared_task


@shared_task
def delete_expired():
    slots = Slots.objects.all()
    for slot in slots:
        if slot.date_time<=datetime.datetime.now():
            slot.delete()
        
    
