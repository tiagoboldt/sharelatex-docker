# We will stick to the official Dockerfile & Version
FROM phusion/baseimage:0.11

# Update the System
RUN apt update
RUN apt upgrade -y

# Install Node and required packages.
RUN /usr/bin/curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y build-essential wget nodejs unzip time imagemagick optipng strace nginx git python zlib1g-dev libpcre3-dev aspell aspell-* redis-server mongodb-server npm netcat

# Install QPDF dependency
WORKDIR /opt
RUN wget https://s3.amazonaws.com/sharelatex-random-files/qpdf-6.0.0.tar.gz && tar xzf qpdf-6.0.0.tar.gz
WORKDIR /opt/qpdf-6.0.0
RUN ./configure && make -j 8 && make install && ldconfig

RUN apt-get install -y texlive-full

# Install NPM/Grunt dependencies.
RUN npm install -g grunt-cli

# Clone Sharelatex
RUN git clone https://github.com/sharelatex/sharelatex.git /sharelatex

# Install Sharelatex.
RUN npm config set user 0 && npm config set unsafe-perm true
ADD package.json /
ADD settings.development.coffee /etc/sharelatex/settings.coffee
# ADD settings.coffee /etc/sharelatex/settings.coffee
ADD sharelatex.sh /usr/bin/sharelatex.sh
RUN wget https://raw.githubusercontent.com/sharelatex/sharelatex-docker-image/master/git-revision.js -O /sharelatex/git-revision.js

WORKDIR /
RUN npm install && rm package.json

WORKDIR /sharelatex
RUN npm install && grunt install

WORKDIR /sharelatex/web
RUN npm install && npm install bcrypt
WORKDIR /sharelatex/web/modules
RUN git clone https://github.com/sharelatex/launchpad-web-module.git launchpad && grunt compile

WORKDIR /sharelatex/clsi
RUN grunt compile:bin

WORKDIR /sharelatex
RUN bash bin/install-services

# Export
EXPOSE 3000
VOLUME /data

# And set out entrypoint
CMD /usr/bin/sharelatex.sh

