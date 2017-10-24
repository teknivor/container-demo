Search for images: docker search <PATTERN>
	docker search nginx

Pull images from Docker hub: 
	docker pull nginx:latest
	docker pull nginx:alpine

Run an image locally: 
	docker run --name my-nginx-instance -p 80:80 -d nginx:latest
	docker run --name my-nginx-instance -p 80:80 -d nginx:alpine -> I don't need to pull an image first / if I attempt to run a container for which there is no image locally, it will pull the image from Docker Hub

	-p80:80?
	-d?

	http://localhost:80

Stop a container

	docker stop <container id>

View a container that is stopped

	docker ps -a

Start am existing container

	docker start <container id>

Connect to a container
	docker exec -ti <container id> bash
	root of the terminal window changes

Modify an image
	eg Modify NGINX default html page

	Problem: no vi or vim or nano
	Solution: install vim!

	Problem: apt-get install vim does not work
	Solution: run apt-get update first

	Edit the file! Which file?
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

	docker commit 7dfae149f2c8 nginx-demo:v1

Run the new image

	docker run --name docker-nginx-on-port-82 -p 82:80 -d nginx-demo:v1
	http://localhost:82

Build an image from a base image using a Dockerfile

	cd C:\Users\tekni\Documents\GitHub\container-demo\sources\
	example of a Dockerfile
	explanation
	building the container
	docker images
	docker build -t nginx-demo:v2 .
	docker images
	run my new image
	docker run --name my-nginx-instance-from-dockerfile -p 83:80 -d nginx-demo:v2

Build an image using docker-compose

	why docker-compose?
	docker-compose file
	docker-compose images
	docker-compose build -> from Dockerfile
	docker-compose create -> create container from docker-compose.yml

Run container remotely (in production?)

	I've run my container locally and tested that my code works
	Now what?

	Let's make it available via my private registry and try to run it on a Docker cluster (in AWS for example :-) )

	Problem: my new image is only available locally and I don't want to have to re-do everything again remotely

Push docker container to a private registry

	Demo my private registry 'nginx-demo' using ECR
	Demo: Create a new registry for nginx-demo-new
	Demo: push container image to new registry

	Connect to my registry:
		Invoke-Expression -Command (aws ecr get-login --no-include-email --region eu-west-1)

		In reality, I am running this command:

		
	Tag my image

		docker tag nginx-demo:v2 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo:v2

	Push my image

		docker push 996389529590.dkr.ecr.eu-west-1.amazonaws.com/nginx-demo:v2

	Now my image is available from everywhere where I can log in

Run container on a cluster with node name as variable displayed on the HTML page

	Demo: run containers on ECS

Tips

	Keeping it light
		Big containers take time to instantiate

	Keeping it simple to a single function

	Keeping it managed by a single team

	The importance of tagging your container with the latest version
		when using Kubernetes, Swarm, Mesos, Marathon etc.
		if containers dies or autoscale, it will put the version that is configured
		if always using latest, risk of having different version running on different containers

	Demo: using latest for different containers instances when changes are being committed to the new version


Latest news

	Docker now support Kubernetes in addition to Docker Swarm (announced at DockerCon in Copenhagen 3 weeks ago)
	