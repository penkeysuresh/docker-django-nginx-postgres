FROM python:2.7

MAINTAINER penkeysuresh@gmail.com
RUN apt-get update

#install nginx, uwsgi and supervisord
RUN apt-get install -y nginx supervisor
RUN yes | pip install uwsgi

# add dependencies to install on docker container
ADD config /home/config
ADD mysite/requirements.txt /home/config/requirements.txt
WORKDIR /home/config

# install project dependencies
RUN yes | pip install -r requirements.txt

# configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mv /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default.backup
ADD config/site-nginx-config /etc/nginx/sites-enabled/site-nginx-config

# add supervisord configuration
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# run supervisord
CMD ["supervisord", "-n"]