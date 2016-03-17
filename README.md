# docker-cacti

Simple docker container with [Cacti](http://cacti.net) built on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).

##### Includes Plugins:

* Aggregate
* CLog
* Cycle
* DSStats
* ErrorImage
* Monitor
* Nectar
* RRDClean
* Realtime
* Remote
* Settings
* Spikekill
* SNMPAgent
* Syslog
* THold (https://github.com/Usuychik/thold)

#### Build

##### (Source)
````bash
git clone https://github.com/nmarus/docker-cacti.git
cd docker-cacti
docker build --rm -t nmarus/docker-cacti .
````

##### (Docker Hub)
````bash
docker pull nmarus/docker-cacti
````

#### Run
````bash
docker run -d -p 80:80 --name docker-cacti nmarus/docker-cacti
````

#### Admin
Open browser to `http://hostname`

