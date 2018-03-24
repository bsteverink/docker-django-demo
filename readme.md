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


## DOCKER COMPOSE

Start stack:

`$ docker-compose up`


Rebuild images and start:

`$ docker-compose up --build`


Execute command in container (in the context of the rest of the stack):

`$ docker-compose run webapp bash`


## RANCHER

0. Build and push docker image
1. Start node and register with Rancher (make sure to add security groups and cloud init)
2. Import docker-compose and start stack
3. Create superuser
4. Show upgrade with allowed hosts
5. Add LB and redirector (redirector will fail because nginx is on port 80)


## JENKINS

1. Create environment API keys in Rancher
2. Make sure rancher-compose is installed on the Jenkins server (bash/rancher-compose-install.sh)
3. Add the Jenkins Github service plugin on Github and provide the Jenkins webhook URL for sending triggers
4. Create a Jenkins pipeline, including API credentials (credentialsId=rancher-server)
5. Push to the Jenkins branch to trigger build and deploy:

`$ git push`