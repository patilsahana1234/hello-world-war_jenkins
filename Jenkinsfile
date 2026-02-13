pipeline {
    agent any

    environment {
        IMAGE_NAME   = "sahanasp123/hello-world-war"
        IMAGE_TAG    = "latest"
        DOCKER_CREDS = "dockerhub-creds"
        CONTAINER_NAME = "hello-war-container"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/patilsahana1234/hello-world-war_jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: DOCKER_CREDS,
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy to Tomcat Server') {
            steps {
                sh """
                docker pull ${IMAGE_NAME}:${IMAGE_TAG}
                docker rm -f ${CONTAINER_NAME} || true
                docker run -d -p 8085:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }
    }
}
