# HLstatsX:CE

An alpine [Docker image](https://hub.docker.com/r/crinis/hlxce/) for running HLstatsX:CE in Docker containers.

## Getting Started
These instructions will help you to get a containerized installation of HLstatsX 1.6.19 running. This includes a web interface, a database with phpmyadmin and a HLstatsX: CE daemon. I recommend to use fixed tags of my Docker images as the latest tag is subject to change.

### Prerequisites
You need a working installation of Docker and Docker compose to follow the installation instructions.

[Install Docker](https://docs.docker.com/engine/installation/)
[Install Docker Compose](https://docs.docker.com/compose/install/)

### Installing
For a basic setup use my pre-configured [docker-compose.yml](docker-compose.yml). Make sure to change all passwords before running this in production.

Run the following command in the same folder as the docker-compose.yml file to get the containers running. 

```
docker-compose up
```
Now you should have your HLstatsX: CE web interface running at port 80, the Perl daemon at port 27500 and an instance of phpMyAdmin at port 8080.
Before you try to use the web interface you should get the sql/install.sql file from the official [HLstatsX: CE repository](https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/) and import it into the hlxce table of the database using phpMyAdmin.

Now add the following commands to the server.cfg file of your gameserver.
```
log on
logaddress_add ip_of_your_host:27500
```
Install the appropriate [HLstatsX: CE repository](https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/) plugins working for your type of gameserver.

## Versioning
I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/crinis/hlxce-docker/tags). 

## License
This project is licensed under the GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details
