# MotionEye / DOCKER / NGINX / CCTV HUB
This is a project for me to access several remote CCTV cameras which are running on a series of [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) machines. It uses the latest version of [Docker CE](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script) and [nginx](https://hub.docker.com/_/nginx).

Each of the [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) is installed with [Raspbian Buster with Desktop](https://www.raspberrypi.org/downloads/raspbian/) and [Motioneye](https://github.com/ccrisan/motioneye).

## Create your image
`:~ $ mkdir /home/pi/nginx`

`:~ $ cd /home/pi/nginx`

Create or Edit your Dockerfile

`:~/nginx $ nano Dockerfile`
```FROM nginx
	RUN apt-get update && \
	 apt-get install -y \
	 nano \
	 && rm -rf /var/lib/apt/lists/*
	COPY html /usr/share/nginx/html
	COPY conf /etc/nginx
```

Save and exit your file.

Download or create the `conf` and `html` directories. These will be copied over to your image.

`:~/nginx $ docker build --no-cache -t <YOUR DOCKER ID>/<IMAGE NAME>:<TAGS> .`

for example

`:~/nginx $ docker build --no-cache -t rpitns/cctv:v1.0-armhf .`

Make sure you include the . at the end.

## Running

### On a single machine

`:~/nginx $ docker run --name cctv -p 80:80 -d  rpitns/cctv:v1.0-armhf`

You can verify it is running by typing

`:~/nginx $ docker ps`

and you should get an output like this

|CONTAINER ID|IMAGE|COMMAND|CREATED|STATUS|PORTS|NAMES|
|------------|-----|-------|-------|------|-----|-----|
|0c2e404dae3c|cctv:v1.0-armhf|"nginx -g 'daemon of…"|About a minute ago|Up About a minute|0.0.0.0:80->80/tcp|CCTV|

### Run as service in Swarm

`:~/nginx $ docker service create --name cctv --mode global  --publish 80:80 rpitns/cctv:v1.0-armhf`

You can verify it is running by typing

`:~/nginx $ docker service ls`

and you should get an output like this

|ID|NAME|MODE|REPLICAS|IMAGE|PORTS|
|----|----|----|--------|-----|-----|
|kbaxtcn559o5|cctv|global|2/2|rpitns/cctv:v1.0-armhf|*:80→80/tcp|


## Contact
Please contact [Dave Brown](mailto:rpitns@gmail.com) if you have any questions or comments.

