FROM ubuntu:14.04
MAINTAINER Primiano Tucci <p.tucci@gmail.com>

RUN apt-get -y update
RUN apt-get -y install git python-pip python-libvirt python-libxml2 supervisor novnc nginx 

RUN git clone https://github.com/retspen/webvirtmgr
WORKDIR /webvirtmgr
RUN git checkout 7f140f99f4 #v4.8.8
RUN pip install -r requirements.txt
ADD local_settings.py /webvirtmgr/webvirtmgr/local/local_settings.py
RUN /usr/bin/python /webvirtmgr/manage.py collectstatic --noinput

ADD supervisor.webvirtmgr.conf /etc/supervisor/conf.d/webvirtmgr.conf
ADD nginx.webvirtmgr.conf /etc/nginx/sites-available/default

ADD bootstrap.sh /webvirtmgr/bootstrap.sh

RUN mkdir /var/local/webvirtmgr
RUN useradd webvirtmgr -g libvirtd -u 1010 -d /var/local/webvirtmgr/ -s /sbin/nologin
RUN chown webvirtmgr:libvirtd -R /webvirtmgr
RUN chown webvirtmgr:libvirtd -R /var/local/webvirtmgr

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN ln -s /etc/nginx/sites-available/webvirtmgr /etc/nginx/sites-enabled
RUN apt-get -ys clean

WORKDIR /
VOLUME /var/local/webvirtmgr

EXPOSE 8080
EXPOSE 6080
CMD ["supervisord", "-n"] 
