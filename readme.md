# Docker Django development and deployment demo

The branches of this repository are structured to follow the development steps that I have taken before arriving at automated 
docker deployment. To follow my footsteps browse through the repository in the following order:

1. docker
2. docker-compose
3. rancher
4. jenkins

Each branch has its own sections of the bash commands listed below. Follow them and you will get an empty Django project
up and running in no time.

Please keep in mind that I use a custom NGINX/Gunicorn image that I have build. I am however not actively maintaining it
so use at your own risk.

Enjoy!


## DOCKERFILE

Build docker image (replace user with your own):

`$ docker build -t bsteverink/docker-demo .`


Start the image in interactive console mode (replace user with your own):

`$ docker run -it -v ${PWD}:/code/ -p 8000:8000 bsteverink/docker-demo bash`


Create Django project:

`$(docker) mkdir app && django-admin startproject dockerdemo app/`


Run migrations & create superuser:

`$(docker) python app/manage.py migrate && python app/manage.py createsuperuser`


Run development server:

`$(docker) python app/manage.py runserver 0.0.0.0:8000`


Run docker image (replace user with your own):

`$ docker run -v ${PWD}:/code/ -p 8000:8000 bsteverink/docker-demo`

_to run in deamon mode:_

`$ docker run -d -v ${PWD}:/code/ -p 8000:8000 bsteverink/docker-demo`


Push image to docker hub (replace user with your own):

`$ docker push bsteverink/docker-demo`