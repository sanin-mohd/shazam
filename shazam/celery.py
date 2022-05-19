import os

from celery import Celery


#Run this in command cmd.exe ==> celery -A shazam worker -l INFO
#Run this in command cmd.exe ==> celery -A shazam beat -l info --scheduler django_celery_beat.schedulers:DatabaseScheduler


# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'shazam.settings')

app = Celery('shazam')

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django apps.
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')

@app.task(bind=True)
def print_task(self):
    print("task")