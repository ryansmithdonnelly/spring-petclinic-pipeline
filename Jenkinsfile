pipeline {
    agent any
    tools {
        jfrog 'jfrog-cli'
    }
    environment {
         DOCKER_IMAGE_NAME = "$DOCKER_REG_URL/$DOCKER_REG_PATH/spring-petclinic:$TAG"
    }
    stages {
        stage('Package') {
            steps {
                git branch: 'main', url: 'https://github.com/spring-projects/spring-petclinic.git'
                sh './mvnw clean package'
                stash includes: 'target/spring-petclinic-*.jar', name: 'petclinic-jar'
            }
        }
        stage('Build Docker Image') {
            steps {
                git branch: 'main', url: 'https://github.com/ryansmithdonnelly/spring-petclinic-pipeline.git'
                unstash 'petclinic-jar'
                script {
                    docker.build("$DOCKER_IMAGE_NAME")
                }
                jf 'docker push $DOCKER_IMAGE_NAME'
            }
        }
    }
}
