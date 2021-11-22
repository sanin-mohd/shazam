from django.apps import AppConfig


class ShowroomConfig(AppConfig):
    name = 'showroom'
    def ready(self):
        import showroom.signals