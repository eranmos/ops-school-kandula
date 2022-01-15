# Create or renew image for jenkins slave

Repository contains Dockerfiles for jenkins slaves and Jenkinsfile for Jenkins jobs.


### How create new image for jenkins slave

1. Create new subfolder  `docker-slaves`.
2. Paste to new subfolder all neccesary configs and new Dockerfile.
3. Go to [create-update-image.groovy][gatlingdoc].
4. Set next parameters:
    - `IMAGE_NAME` - the same name as new subfolder inside docker-slaves
    - `IMAGE_TAG` - tag for new docker image
5. New docker image for jenkins slave will be created and pushed to Docker Hub
   https://hub.docker.com/u/erandocker

### How update existing image for jenkins slave

1. Go to subfolder with the same name as slave Name inside folder.
2. Change Dockerfile, create MR to DevOps Team member to review it and proceed further after approval.
3. Go to [create-update-image.groovy][create-update-image.groovy].
4. Set next parameters:
    - `IMAGE_NAME` - name for docker image (can use old name)
    - `IMAGE_TAG` - tag for docker image. Changing base image version or tool version is a major change, thus a major version should be incremented. Minor version are considered changes related to adding tools, configs, etc.
5. New docker image for jenkins slave will be updated and pushed to Docker hub

[Jenkins-Slave-Docker-Image-Creationw job]: https://jenkins.kandula.click/job/Jenkins-Slave-Docker-Image-Creation/

### Jenkins job for creation new jenkins slave image

```
https://jenkins.kandula.click/job/Jenkins-Slave-Docker-Image-Creation/
```