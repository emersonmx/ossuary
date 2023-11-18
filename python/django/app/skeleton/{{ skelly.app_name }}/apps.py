from django.apps import AppConfig


class {{ skelly.app_name | replace(from="_", to=" ") | title | split(pat=" ") | join }}Config(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = '{{ skelly.app_name }}'
