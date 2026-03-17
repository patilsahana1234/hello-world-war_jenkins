pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "docker.io/sahanasp123/hello-world-war"
        HELM_CHART   = "hello-war-chart"
        HELM_VERSION = "0.1.1"
        JFROG_URL    = "https://trial5tqwdi.jfrog.io/artifactory/jenkins-helm"
        KUBE_NS      = "default"
    }

    stages {

        stage('Maven Build WAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}
                        docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest
                        docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Helm Package and Push to JFrog') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jfrog-creds', usernameVariable: 'JFROG_USER', passwordVariable: 'JFROG_PASS')]) {
                    sh """
                        helm lint ${HELM_CHART}
                        helm package ${HELM_CHART} --version ${HELM_VERSION}
                        curl -u \$JFROG_USER:\$JFROG_PASS \
                            -T ${HELM_CHART}-${HELM_VERSION}.tgz \
                            ${JFROG_URL}/${HELM_CHART}-${HELM_VERSION}.tgz
                        helm repo index . --url ${JFROG_URL}
                        curl -u \$JFROG_USER:\$JFROG_PASS \
                            -T index.yaml \
                            ${JFROG_URL}/index.yaml
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jfrog-creds', usernameVariable: 'JFROG_USER', passwordVariable: 'JFROG_PASS')]) {
                    sh """
                        helm repo add jfrog-helm ${JFROG_URL} \
                            --username \$JFROG_USER \
                            --password \$JFROG_PASS \
                            --force-update
                        helm repo update
                        helm upgrade --install ${HELM_CHART} jfrog-helm/${HELM_CHART} \
                            --version ${HELM_VERSION} \
                            --set image.tag=${BUILD_NUMBER} \
                            --namespace ${KUBE_NS} \
                            --wait \
                            --timeout 2m
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh """
                    kubectl rollout status deployment/${HELM_CHART} \
                        --namespace ${KUBE_NS} \
                        --timeout=120s
                    kubectl get pods -n ${KUBE_NS} -l app=${HELM_CHART}
                    kubectl get svc ${HELM_CHART} -n ${KUBE_NS}
                """
            }
        }
    }

    post {
        success {
            echo "SUCCESS - image tag: ${BUILD_NUMBER}"
        }
        failure {
            echo "FAILED - check logs above"
        }
        always {
            sh "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER} || true"
            sh "docker rmi ${DOCKER_IMAGE}:latest || true"
        }
    }
}
