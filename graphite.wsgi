# import os, sys
# sys.path.append('/opt/graphite/lib')
# os.environ['DJANGO_SETTINGS_MODULE'] = 'graphite.settings'

# import django.core.handlers.wsgi

# application = django.core.handlers.wsgi.WSGIHandler()

# from graphite.logger import log
# log.info("graphite.wsgi - pid %d - reloading search index" % os.getpid())
# import graphite.metrics.search
import os
import sys

from django.core.wsgi import get_wsgi_application

os.environ['DJANGO_SETTINGS_MODULE'] = 'graphite.settings'
application = get_wsgi_application()