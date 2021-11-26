# Generated by Django 3.1 on 2021-11-24 08:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0003_auto_20211124_1052'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='payment_option',
            field=models.CharField(choices=[('Paypal', 'Paypal'), ('Razorpay', 'Razorpay')], max_length=10, null=True),
        ),
    ]