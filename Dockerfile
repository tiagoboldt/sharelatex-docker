from ubuntu:latest
RUN apt-get update
RUN apt-get install -y --force-yes npm git mongodb-server redis-server wget sudo
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN git clone https://github.com/scottkosty/install-tl-ubuntu.git; \
  	cd install-tl-ubuntu; \
	TLREPO=http://mirrors.fe.up.pt/pub/CTAN/ ./install-tl-ubuntu

RUN git clone https://github.com/sharelatex/sharelatex.git; \
	cd sharelatex; \
	git checkout v0.1.4; \
	npm install; \
	npm install -g grunt-cli; \
	grunt install
ADD sharelatex.sh /usr/bin/sharelatex.sh

EXPOSE 3000
