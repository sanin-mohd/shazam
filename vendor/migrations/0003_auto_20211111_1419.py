# Generated by Django 3.1 on 2021-11-11 08:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vendor', '0002_auto_20211111_1030'),
    ]

    operations = [
        migrations.AlterField(
            model_name='vendor',
            name='mobile',
            field=models.CharField(max_length=10, unique=True),
        ),
    ]
