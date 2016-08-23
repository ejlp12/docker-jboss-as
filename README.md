# JBoss 7.1.3 final on Alpine Linux + Oracle JRE

Base image for JBoss 7.1.3 deployment.

## Target usage: custom derived images with your own deployment

Create a new Dockerfile and copy everything over the base image:

```
FROM netservicespa/docker-jboss-as:7.1.3
ADD file.ear /opt/jboss-as-7.1.3.Final/standalone/deployments/file.ear
COPY standalone.xml /opt/jboss-as-7.1.3.Final/standalone/configuration/standalone.xml
```

## Management password (inherited from pascalgrimaud/jboss-as:7.1.1)

Quick start with binding to port 8080, 9990 and random password :

```
docker run -d -p 8080:8080 -p 9990:9990 netservicespa/docker-jboss-as:7.1.3
```

To get the password :

```
docker logs <container id>
```

Start and set a specific password for JBoss admin user :

```
docker run -d -p 8080:8080 -p 9990:9990 -e JBOSS_PASS="pass" netservicespa/docker-jboss-as:7.1.3
```

If you forget the admin password, delete the file .password and restart the container :

```
docker exec -it <container id> rm /.password
```

## BUT

It's better if you *AVOID* runtime modification of containers, as they are *TRANSIENT* by design.
Code is king. Modifications, in a container world, have to be persisted in source code.