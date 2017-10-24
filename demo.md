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

		docker login -u AWS -p eyJwYXlsb2FkIjoiQ2h3K2pLSEcwNUtib1lETUxqaVBIcC9CNlpjRHdBVEl2MFZYcm9wNkU1NzRHQlJHdm9uV3phb3BEb3Jyd2dpR1o2M2pkcTZHOTBvU3M2ai8xU0twVVhoV2Z3UjVMbDVuT1pCRVZuTEQ3K3g1SG8vQTRVdDlBdFRQK0ZKU2ZLYW5PTFI5cWhqZURydW9yem16dEFVbDUwQWVyeUltSUl0R3RkejUwSHUxaFgvMHV6czBwR0dmdUkxbFVtTlVwOXdVMUFnR2lldTBvcHdFRDZVWlRtMFVIdkw2enZKV0lDaGhyOTJBZEU4VFd5ekJtNFZIYzM1S2FsZVAxQ1ZzcDl5enBHV1NBMEIrWFlpZmtwRXRXajg1UmlTWTBybFA1V2txT3lsdkk2RnJ3L3VMcWMxODhvU2lxRUV6MnJ1ei9sREFaNEpVU0VCVW1vNytqWkxINHpqTTdiTHkrQ0xCWjdBMEdhUVloZXhubEtaU1V2a2IrRUhpa3VhUnVWRUttdURRc0x4UldiQzljRysxd0I2OXFKT25qaCtBajBJeFlUelJBcGVtUkoveXR2djQvOTBBSE9hNURhaFJEOTQ3Q0VvK09UMEpudmFWVGVZbjhSRG1zMC81cXo4NDVDaVBoRldoejYvWHRsYjZJQ2w4M2RXMTB5WUV0TWZDR2dGYjNXY2ZLSmhoR3RxRFloVi81VmhHaXc5dWZjd0hOK0lRcmNleExlaUQ1TjRBdFNrcVVzUklHRldtSldnOS9RR29Sa2xORlRuMGhuWmxuTDJWV0FmNGtTcm1YS0t4bmgyd3ZFbDg3cFZHOWk2WG8vODlOUFhucmNvSis5clhmVjJHR2JBTmhieVNNNWhRNzBiSEVxQzRPL0tOYXE3VW44Rk1qL0tLUFBtaHlNUTVBU09EeVN2QWNMUm5CYVZUcHN0eTBNbGxFRTV2R1BBaEZiV3VBeW9DdFBGSU82NDJYRS9RYyttSHZIUmpyaldOWUs5WjVBZGZGNGI4NVFFWU9meENLSTFCcVJ4KzJ5RXpBOVdIRXBvblo3YTZxQkRsWTErbDgyTG9WOGlpU1NiRjhVUUhIbVhkWUhia0JiaFhUWmNhd2wrMzBvcFVJSjJwZm1HK2NpRm1qMDNDUFdBMXh6S1JCMm82ODI1M3Y2a20zT2d4V0tEMVZvTGp1SlV5MktkTVZDMFJ3UGpwVmpGVEh1NkJXQWpjWjhkalNYaE1MWGNJNmNUZ1VjTWU5Mmk5b2c5MGtBRThGcVB6NTM5S0UvdlBxMXRML1ZTMyswRTNhRUVTeFJiS25nbWQ0bGkvZmxjTmllNk5UMGNKRG9ZTXZsdjJYdG8xdGZNWGI2SGphSWNLeWYvWmIzVmhXTDUwVCtNblh1VG0yNU1EdGpVRStyb1lsMzhUb09tSWpQYjVzdWllU2FaTVdBNEJCN1VaRFB6USIsImRhdGFrZXkiOiJBUUVCQUhoK2RTK0JsTnUwTnhuWHdvd2JJTHMxMTV5amQrTE5BWmhCTFpzdW5PeGszQUFBQUg0d2ZBWUpLb1pJaHZjTkFRY0dvRzh3YlFJQkFEQm9CZ2txaGtpRzl3MEJCd0V3SGdZSllJWklBV1VEQkFFdU1CRUVETW8wVmhVVFhKQXNERFo5T3dJQkVJQTdEVUluSmxxbTIyOUFoL0NiL1JRM1pCTDlSOEFoRDlvMzdJSHVlZlY5NGdyOVFzbHRDbzEvT1VtQ29RY1R5VTVxWm54RzVuZE5hWmIvRHNVPSIsInZlcnNpb24iOiIyIiwidHlwZSI6IkRBVEFfS0VZIiwiZXhwaXJhdGlvbiI6MTUwODg5NDExNH0= https://996389529590.dkr.ecr.eu-west-1.amazonaws.com

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
	