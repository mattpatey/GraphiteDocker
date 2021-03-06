SECRET_KEY = 'docker'

TIME_ZONE = 'Europe/Berlin'

GRAPHITE_ROOT = '/opt/graphite/'
CONF_DIR = '/opt/graphite/conf/'
STORAGE_DIR = '/opt/graphite/'
CONTENT_DIR = '/opt/graphite/webapp/content/'
WHISPER_DIR = '/opt/graphite/storage/whisper/'

DEFAULT_CACHE_DURATION = 0

LOG_DIR = '/var/log/graphite/'
LOG_RENDERING_PERFORMANCE = True
LOG_METRIC_ACCESS = True
LOG_CACHE_PERFORMANCE = True

DATABASES = {
    'default': {
        'NAME': '/opt/graphite/storage/graphite.db',
        'ENGINE': 'django.db.backends.sqlite3',
        'USER': '',
        'PASSWORD': '',
        'HOST': '',
        'PORT': ''
            }
    }

CARBONLINK_HOSTS = ["127.0.0.1:7002:a"]
CARBONLINK_TIMEOUT = 1.0
