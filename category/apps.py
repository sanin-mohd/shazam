from django.apps import AppConfig


class CategoryConfig(AppConfig):
    name = 'category'
    def ready(self):
        import category.signals
