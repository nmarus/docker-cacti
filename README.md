# docker-cacti

Simple docker container with [Cacti](http://cacti.net) built on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).

#### Build:
````bash
git clone https://github.com/nmarus/docker-cacti.git
cd docker-cacti
docker build --rm -t docker-cacti .
````

#### Run:
````bash
docker run -d -p 80:80 --name docker-cacti docker-cacti
````

#### Admin:
Open browser to `http://hostname`
