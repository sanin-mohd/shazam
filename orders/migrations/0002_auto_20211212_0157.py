# Generated by Django 3.1 on 2021-12-11 20:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='mobile',
            field=models.BigIntegerField(),
        ),
        migrations.AlterField(
            model_name='order',
            name='pending_amount',
            field=models.BigIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='order',
            name='zip_code',
            field=models.BigIntegerField(),
        ),
    ]
