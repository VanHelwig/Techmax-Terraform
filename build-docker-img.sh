#!/bin/bash

# create a repository to store the docker image in docker hub

# launch an ec2 instance. open port 80 and port 22

# install and configure docker on the ec2 instance
sudo dnf update -y
sudo dnf install docker -y
sudo service docker start
sudo systemctl enable docker

# create a dockerfile

# build the docker image
sudo docker build -t techmax .

# login to your Docker Hub account using an environment variable
if [ -z "$DOCKER_PASSWORD" ]; then
    echo "Error: DOCKER_PASSWORD environment variable is not set."
    exit 1
fi

echo "$DOCKER_PASSWORD" | sudo docker login --username <your-docker-id> --password-stdin

# use the docker tag command to give the image a new name
sudo docker tag techmax 

# push the image to your docker hub repository
sudo docker push vanhelwig/techmax-terraform

# start the container to test the image 
sudo docker run -dp 80:80 vanhelwig/techmax-terraform

# referances
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/create-container-image.html
# https://docs.docker.com/get-started/02_our_app/
# https://docs.docker.com/engine/reference/commandline/login/#provide-a-password-using-stdin