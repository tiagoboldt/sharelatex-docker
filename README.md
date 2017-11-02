# sharelatex-docker

A docker image for running sharelatex. Should work, but ShareLaTex already have their own official image: https://hub.docker.com/r/sharelatex/sharelatex/ 

## Docker Image

To acquire the build image from the docker's repositories execute:

	docker pull  tiagoboldt/sharelatex-docker

## Dockerfile

To build the image from source execute:

	git clone https://github.com/tiagoboldt/sharelatex-docker.git
	cd sharelatex-docker
	docker build -t tiagoboldt/sharelatex-docker:sharelatex .

## Execution

To start the instance execute: 
	
	mkdir /srv/sharelatex-data
	docker run -d -p 3000:3000 -v /srv/sharelatex-data:/data tiagoboldt/sharelatex-docker
	
It will be available on http://localhost:3000. Files will be kept in `/srv/sharelatex-data`. First execution might take some time to be ready. This is due to MongoDb pre-allocation.  

## Create first user

    docker run -it -p 3000:3000 -v /srv/sharelatex-data:/data tiagoboldt/sharelatex-docker /bin/bash
    cd /sharelatex/web
    sharelatex.sh > /dev/null &
    # wait until sharelatex is available at http://localhost:3000
    grunt create-admin-user --email=joe@example.com
    # click the url and set your password
    # new users can be registred at http://localhost:3000/admin/register
