# sharelatex-docker

## Docker Image

To acquire the build image from the docker's repositories execute:

	docker pull  tiagoboldt/sharelatex-docker

## Dockerfile

To build the image from source execute:

	git clone git@github.com:tiagoboldt/sharelatex-docker.git
	cd sharelatex-docker
	docker build -t tiagoboldt/sharelatex-docker:sharelatex .

## Execution

To start the instance execute: 
	
	docker run -d -p 3000:3000 tiagoboldt/sharelatex-docker:sharelatex sharelatex.sh
	
It will be available on http://localhost:3000. Files will be kept in the user_files folder and database on db folder. First execution might take some time to be ready. This is due to MongoDb pre-allocation.  
