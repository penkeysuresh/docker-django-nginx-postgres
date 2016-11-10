# Docker configuration for a Django app 

This set up is a sample configuration of a django app. This configuration contains below features.

* ``uwsgi`` as application container server with ``nginx`` reverse proxy
* ``postgres`` database for persistence using ``docker-volume``
* ``docker-compose`` to manage the images
* live reloading of code -  suitable for development work flow

# Setting up your application using above configuration

Below is a guide to setup your project with the above configuration

1. Replace the ``mysite`` folder with your-app folder, and change path to your folder in ``docker-compose.yml``
2. Change the module flag in ``config/uwsgi.ini`` file with your-app.uwsgi (This will take care of uwsgi configuration for your app)
3. make sure you have your postgres settings and static file serving settings in your settings.py 
4. Now run ``docker-compose up``. Your django app will be available at http://localhost
5. Next you'll have to do one time database creation. Do a ``docker ps`` and login to postgres container using ``docker exec -it <hash> bash`` (Alternatively you can restore your old database form a dump file using pg_restore)
  1. run ``psql -U postgres``
  2. create database user and password using ``CREATE ROLE mydatabaseuser WITH CREATEDB LOGIN PASSWORD 'mypassword';``
  3. create database using ``CREATE DATABASE mydatabase;``
6. Now login to web container, navigate to /code folder and do migrations and create superuser.

Your django app is ready :)
