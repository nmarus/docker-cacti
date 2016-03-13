# docker-cacti

Simple docker container with [Cacti](http://cacti.net) built on [phusion/baseimage-docker](https://github.com/phusion/baseimage-docker).

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

#### Customize Dockerfile
````bash
FROM nmarus/docker-cacti

# Install Settings Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -O settings-v0.71-1.tgz http://docs.cacti.net/_media/plugin:settings-v0.71-1.tgz && \
  tar -zxvf settings-v0.71-1.tgz && \
  rm settings-v0.71-1.tgz

# Install THold Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -O thold-v0.5.0.tgz http://docs.cacti.net/_media/plugin:thold-v0.5.0.tgz && \
  tar -zxvf thold-v0.5.0.tgz && \
  rm thold-v0.5.0.tgz

# Install Realtime Plugin
RUN cd /usr/share/cacti/site/plugins/ && \
  wget -O realtime-v0.5-2.tgz http://docs.cacti.net/_media/plugin:realtime-v0.5-2.tgz && \
  tar -zxvf realtime-v0.5-2.tgz && \
  rm realtime-v0.5-2.tgz
```

