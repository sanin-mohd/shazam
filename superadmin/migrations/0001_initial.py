# Generated by Django 3.1 on 2021-12-11 06:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('category', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='BookingPrice',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('booking_price', models.IntegerField(default=999)),
                ('category', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='category.category')),
            ],
        ),
    ]
