# spring-petclinic-pipeline

spring-petclinic-pipeline is a simple project containing a Jenkins pipeline (Jenkinsfile) and a Dockerfile for the [spring-petclinic](https://github.com/spring-projects/spring-petclinic) project.  The pipeline checks out the source repository, compiles and runs unit tests, then builds a Docker image and pushes it to an Artifactory repository.

## Usage

### Prerequisites

#### Agent
The Jenkins [agent](https://www.jenkins.io/doc/book/using/using-agents/)(s) must have [Docker](https://docs.docker.com/engine/install/) and [JFrog CLI](https://docs.jfrog.com/integrations/docs/download-and-install-the-jfrog-cli) installed and available.  The 'jenkins' user must be in the 'docker' group (usermod -aG docker jenkins).

#### Jenkins
The [Docker Pipeline](https://plugins.jenkins.io/docker-workflow/) and [JFrog](https://plugins.jenkins.io/jfrog/) plugins must be installed and enabled.  A [credential](https://www.jenkins.io/doc/book/using/using-credentials/) must be created containing login details for the target Artifactory instance.  JFrog CLI should be configured [as a tool](https://plugins.jenkins.io/jfrog/#plugin-content-configuring-jfrog-cli-as-a-tool).

### Pipeline
Create a new Pipeline item in Jenkins.   Under "General," check the "This project is parameterized" box, and enter the following parameters (with optional defaults):

DOCKER_REG_URL: hostname or IP and port for Docker repository

DOCKER_REG_PATH: path to Docker repository

TAG: image tag.

Under "Pipeline," for "Definition," select "Pipeline script from SCM."  Choose "Git" for "SCM," and enter the URL of this repository for "Repository URL" ("https://github.com/ryansmithdonnelly/spring-petclinic-pipeline.git").  "Branch Specifier" should also be updated to "*/main" if necessary.  Click "Save," then "Build with Parameters," override defaults as necessary, and click "Build."  Upon completion, an image will be available at $DOCKER_REG_URL/$DOCKER_REG_PATH/spring-petclinic:$TAG.

### spring-petclinic Container
In an environment with Docker and access to the Artifactory repository, run the following command (substituting variables or using environment variables): "docker run -it -p 8080:8080 --rm $DOCKER_REG_URL/$DOCKER_REG_PATH/spring-petclinic:$TAG"

In a browser, navigate to [localhost:8080](localhost:8080) and observe that the spring-petclinic application is running.
