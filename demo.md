Search for images: docker search <PATTERN>
	docker search nginx
	docker search reddis
	docker search postgres

	At the top the official image
	In the list, modified images published by others
	Detailed can be found on Docker Hub : https://hub.docker.com/

Pull images from Docker hub: 
	docker pull nginx:latest
	docker pull nginx:alpine

List pulled images
	docker images

Run an image locally: 
	docker run --name my-nginx-instance -p 80:80 -d nginx:latest
	docker run --name my-nginx-instance -p 80:80 -d nginx:alpine -> I don't need to pull an image first / if I attempt to run a container for which there is no image locally, it will pull the image from Docker Hub

	-p80:80?
	-d?

	http://localhost:80

Stop a container

	docker stop <container id>

View a container that is stopped

	docker ps doesn't display containers that are stopped
	Must run docker ps -a

Start an existing container

	docker start <container id>

Connect to a container
	docker exec -ti <container id> bash
	
	Notice that the root of the terminal window changes

	Tip: bash needs to be in the PATH of the container - otherwise, needs to call /bin/bash
	Some container shell are different from bash
	eg. Alpine container is /bin/sh

Modify an image
	eg Modify NGINX default html page

	Problem: no vi or vim or nano
	Solution: install vim!

	Problem: apt-get install vim does not work
	Solution: run apt-get update first

	Edit the file! Which file? Let's figure out the default HTML file for the official nginx image
	vim /etc/nginx/conf.d/default.conf

	    location / {
	        root   /usr/share/nginx/html;
	        index  index.html index.htm;
	    }

	vim /usr/share/nginx/html/index.html

Start a new instance on another port

	docker run --name my-nginx-instance-on-port-81 -p 81:80 -d nginx:latest
	docker ps
	http://localhost:81

	Problem: my changes are not reflected in the new instance of the container
	Solution: commit changes to a new image!

Commit changes to a new image

	docker commit <container id> nginx-demo:v1

	Notice the v1 - I am keeping 'latest' intact and creating a new image with tag "v1"
	Tag can be anything (foo, bar) eg. nginx:foo, nginx:bar, nginx:v1

Run the new image

	docker run --name docker-nginx-on-port-82 -p 82:80 -d nginx-demo:v1
	http://localhost:82

	Changes are now reflected in my new container

Build an image from a base image using a Dockerfile

	cd C:\Users\tekni\Documents\GitHub\container-demo\sources\
	example of a Dockerfile
	explanation
	building the container
	docker images
	docker build -t nginx-demo:v2 . <- now it's v2
	docker images
	run my new image
	docker run --name my-nginx-instance-from-dockerfile -p 83:80 -d nginx-demo:v2

Run container remotely (in production!)

	I've run my container locally and tested that my code works
	Now what?

	Problem: my new image is only available locally and I don't want to have to re-build all images with my changes everything again remotely
	Solution 1: I can commit my Dockerfile or docker-compose.yml to Git (Stash/BitBucket) and build the container on my new host - not ideal
	Solution 2: Let's make it available via my private registry and try to run it on a Docker cluster (in AWS for example :-) ) - preferred

Push docker container to a private registry

	Demo my private registry 'nginx-demo' using ECR
	Demo: Create a new registry for nginx-demo-new
	Demo: push container image to new registry

	Connect to my registry:
		Invoke-Expression -Command (aws ecr get-login --no-include-email --region eu-west-1)

		In reality, I am running this command:

		
	Tag my image

		docker tag nginx-demo:v2 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo-new:v2

	Push my image

		docker push 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo-new:v2

	Now my image is available from everywhere where I can log in

Run container on a cluster with node name as variable displayed on the HTML page

	Demo: run containers on ECS

	Login:
	docker login ...

	docker pull 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo-new:v2

	docker run --name docker-nginx-on-my-ecs-cluster -p 8080:80 -d 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo-new:v2

	If I run docker run --name docker-nginx-on-my-ecs-cluster -p 8080:80 -d nginx-demo-new:v2
		My image gets pulled from Docker Hub and it will fail because nginx-demo-new:v2 doesn't exist in Docker Hub

	Verify that I am running different OS version:
	 on host: cat /etc/*release
	 on container: docker exec -ti <container id> bash then cat /etc/*release



	Demo: using latest for different containers instances when changes are being committed to the same version



Bonus: build a voting application based on Python, Redis, Node.js and PostgreSQL using docker-compose

	why docker-compose? A service is usually made of multiple components (front-end, app, logic, db that are linked to each other)
	docker-compose file
	docker-compose images
	docker-compose build -> from Dockerfile
	docker-compose create -> create container from docker-compose.yml

	https://github.com/dockersamples/example-voting-app
	git clone git@github.com:dockersamples/example-voting-app.git
	docker-compose up

	Connect to blablabla and vote if you prefer cats or dogs!

