pipeline {
    agent { label 'java' }
    stages {
        stage('checkout') {
             steps {
               sh "rm -rf hello-world-war_jenkins"
               sh "git clone https://github.com/patilsahana1234/hello-world-war_jenkins"
           }
        }
        stage('Build') {
             steps {
               sh "mvn clean package"
           }
        }
        stage('Deploy') {
             steps {
               sh "cp /home/slave1/workspace/Jenkins_pipeline/target/hello-world-war-1.0.0.war /opt/apache-tomcat-10.1.49/webapps"
           }
        }
    }
}


