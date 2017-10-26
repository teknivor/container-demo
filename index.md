% Docker Crash Course
% Ion Mudreac
% July 2017

---

#### The origins of the Docker Project

* dotCloud was operating a PaaS, using a custom container engine.
* This engine was based on OpenVZ (and later, LXC) and AUFS.
* It started (circa 2008) as a single Python script.
* March 2013, PyCon, Santa Clara

---

#### The underlying technology Container format libcontainer

* Namespaces
    * These namespaces provide a layer of isolation.
* Control groups
    * A cgroup limits an application to a specific set of resources.
* Union file systems
    * UnionFS, are file systems that operate by creating layers

---

#### An Introduction to Docker Image

* image
    * An image is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

---

#### An Introduction to Docker Container

* container
    * A container is a runtime instance of an image – what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.

---

#### An Introduction to Docker Dockerfile

* Dockerfile
    * Dockerfile will define what goes on in the environment inside your container.

---

#### Dockerfile

```
# Use an official Python runtime as a base image
FROM python:2.7-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```


---

### Docker vs VM


![](Images/VM.PNG)


---

### Docker vs VM


![](Images/Docker.PNG)

