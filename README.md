sharelatex-docker
=================

Sharelatex instalation via Dockerfile. To build the image execute:

	git clone git@github.com:tiagoboldt/sharelatex-docker.git
	cd sharelatex-docker
	docker build -t sharelatex .

To start the instance execute: 
	
	docker run -d -p 3000:3000 sharelatex sharelatex.sh
	
It will be available on http://localhost:3000. Files will be kept in the user_files folder and database on db folder. 
