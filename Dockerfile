FROM phusion/baseimage:0.9.16
RUN apt-get update
RUN apt-get install -y aspell aspell-en aspell-af aspell-am aspell-ar aspell-ar-large aspell-bg aspell-bn aspell-br aspell-ca aspell-cs aspell-cy aspell-da aspell-de aspell-de-alt aspell-el aspell-eo aspell-es aspell-et aspell-eu-es aspell-fa aspell-fo aspell-fr aspell-ga aspell-gl-minimos aspell-gu aspell-he aspell-hi aspell-hr aspell-hsb aspell-hu aspell-hy aspell-id aspell-is aspell-it aspell-kk aspell-kn aspell-ku aspell-lt aspell-lv aspell-ml aspell-mr aspell-nl aspell-no aspell-nr aspell-ns aspell-or aspell-pa aspell-pl aspell-pt-br aspell-ro aspell-ru aspell-sk aspell-sl aspell-ss aspell-st aspell-sv aspell-ta aspell-te aspell-tl aspell-tn aspell-ts aspell-uk aspell-uz aspell-xh aspell-zu 
RUN apt-get install -y --force-yes npm git mongodb-server redis-server wget sudo time

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
