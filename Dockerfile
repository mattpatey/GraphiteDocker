FROM ubuntu:14.04

RUN apt-get update && apt-get install --assume-yes \
    automake \
    autotools-dev \
    build-essential \
    python2.7 \
    apache2 \
    git-core \
    libldap2-dev \
    libsasl2-dev \
    libapache2-mod-python \
    libcairo2-dev \
    # libffi-dev \
    libtool \
    memcached \
    python-dev \
    wget

COPY get-pip.py get-pip.py
RUN python get-pip.py \
    && pip install --no-use-wheel \
       Django \
       django-tagging \
       python-ldap \
       python-memcached \
       Twisted \	
       txamqp \
       uwsgi

WORKDIR /tmp
# RUN wget wget http://freehackers.org/~tnagy/tnagy1024.asc \
#     && gpg --import tnagy1024.asc \
#     && wget https://waf.io/waf-1.8.12.tar.bz2 https://waf.io/waf-1.8.12.tar.bz2.asc \
#     && gpg --verify waf-1.8.12.tar.bz2.asc \
#     && tar jxvf wget waf-1.8.12.tar.bz2 \
#     && cd waf-1.8.12 \
RUN git clone git://git.cairographics.org/git/py2cairo \
    && cd py2cairo \
    && ./autogen.sh --prefix=$( python -c "import sys; print sys.prefix" ) \
    && make \
    && make install

# Install Whisper
#
WORKDIR /tmp    
RUN git clone https://github.com/graphite-project/whisper.git \
    && cd whisper \
    && git checkout 0.9.x \
    && python setup.py install

# Install and confgure Carbon
#
WORKDIR /tmp
RUN git clone https://github.com/graphite-project/carbon.git \
    && cd carbon \
    && git checkout 0.9.x \
    && python setup.py install
COPY carbon.conf /opt/graphite/conf/carbon.conf
COPY storage-schemas.conf /opt/graphite/conf/storage-schemas.conf

# Install and configure Graphite webapp
#
WORKDIR /tmp
RUN git clone https://github.com/graphite-project/graphite-web.git \
    && cd graphite-web \
    && git checkout 0.9.x \
    && python check-dependencies.py \
    && python setup.py install \
    && cd /opt/graphite/webapp/graphite \
    && python manage.py syncdb --noinput
COPY local_settings.py /opt/graphite/webapp/graphite/local_settings.py
COPY graphite.wsgi /opt/graphite/conf/graphite.wsgi

RUN apt-get install --assume-yes supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN mkdir /var/log/graphite

EXPOSE 8000 2003 2004 7002
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
