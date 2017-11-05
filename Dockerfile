FROM phusion/baseimage:latest
RUN apt-get update
RUN apt-get install -y aspell-*
RUN apt-get install -y --force-yes npm git mongodb-server redis-server wget sudo time netcat

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN git clone https://github.com/scottkosty/install-tl-ubuntu.git; \
  	cd install-tl-ubuntu; \
	./install-tl-ubuntu

RUN git clone -b v0.2.0 --single-branch https://github.com/sharelatex/sharelatex.git; \
	cd sharelatex; \
	npm install; \
	npm install -g grunt-cli; \
	grunt install;

# install missing dependency until sharelatex resolves this bug
RUN npm install v8-profiler

ADD sharelatex.sh /usr/bin/sharelatex.sh
ADD settings.development.coffee /etc/sharelatex/settings.coffee

CMD sharelatex.sh

EXPOSE 3000
