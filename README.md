# sharelatex-docker

A docker image for running sharelatex. Still working, losely maintained, as ShareLaTex already has their own official image: https://hub.docker.com/r/sharelatex/sharelatex/
In contrast to the official repository this version runs in a single container.

[![Build Status](https://travis-ci.com/tiagoboldt/sharelatex-docker.svg?branch=master)](https://travis-ci.com/tiagoboldt/sharelatex-docker)

## Docker Image

To acquire the build image from the docker's repositories execute:

	docker pull  tiagoboldt/sharelatex-docker

## Dockerfile

To build the image from source execute:

	git clone https://github.com/tiagoboldt/sharelatex-docker.git
	cd sharelatex-docker
	docker build -t tiagoboldt/sharelatex-docker:sharelatex .

  Please keep in mind the building process will take up to 1 hour.

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

## ShareLaTex official image

ShareLaTex has an official docker image. It was introduced after this image was made available and
it is not as well documented, hence, this image is still maintained.
