# Generated by Django 3.1 on 2022-05-18 05:55

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('testDrive', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='slots',
            name='date_time',
            field=models.DateTimeField(default=datetime.datetime(2022, 5, 25, 11, 25, 18, 222099)),
        ),
    ]
