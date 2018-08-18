# We will stick to the official Dockerfile & Version
FROM phusion/baseimage:0.9.16

# Update the System
RUN apt update
RUN apt upgrade -y

# Install Node and required packages.
RUN /usr/bin/curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
RUN apt-get install -y build-essential wget nodejs unzip time imagemagick optipng strace nginx git python zlib1g-dev libpcre3-dev aspell aspell-en aspell-af aspell-am aspell-ar aspell-ar-large aspell-bg aspell-bn aspell-br aspell-ca aspell-cs aspell-cy aspell-da aspell-de aspell-de-alt aspell-el aspell-eo aspell-es aspell-et aspell-eu-es aspell-fa aspell-fo aspell-fr aspell-ga aspell-gl-minimos aspell-gu aspell-he aspell-hi aspell-hr aspell-hsb aspell-hu aspell-hy aspell-id aspell-is aspell-it aspell-kk aspell-kn aspell-ku aspell-lt aspell-lv aspell-ml aspell-mr aspell-nl aspell-no aspell-nr aspell-ns aspell-or aspell-pa aspell-pl aspell-pt-br aspell-ro aspell-ru aspell-sk aspell-sl aspell-ss aspell-st aspell-sv aspell-ta aspell-te aspell-tl aspell-tn aspell-ts aspell-uk aspell-uz aspell-xh aspell-zu redis-server mongodb-server

# Install QPDF dependency
WORKDIR /opt
RUN wget https://s3.amazonaws.com/sharelatex-random-files/qpdf-6.0.0.tar.gz && tar xzf qpdf-6.0.0.tar.gz
WORKDIR /opt/qpdf-6.0.0
RUN ./configure && make && make install && ldconfig

# Clone & Install TexLive
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; mkdir /install-tl-unx; tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1
# RUN echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile
RUN echo "selected_scheme scheme-full" >> /install-tl-unx/texlive.profile; /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile
RUN rm -r /install-tl-unx; rm install-tl-unx.tar.gz
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/texlive/2017/bin/x86_64-linux/
WORKDIR /usr/local/texlive/2018/bin/x86_64-linux
RUN ./tlmgr install latexmk
RUN ./tlmgr install texcount

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

