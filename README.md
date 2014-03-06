sharelatex-docker
=================

Sharelatex instalation via Dockerfile. To build the image execute:

	docker build -t sharelatex .

To start the instance execute: 
	
	docker run -d -p 3000:300 sharelatex 
	
It will be running on port 3000. Files will be kept in the user_files folder and database on db folder. 