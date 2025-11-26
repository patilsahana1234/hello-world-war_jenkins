pipeline {
    agent any
    stages {
        stage('BuildMaven') {
             steps {
               sh "sudo apt update -y"
               sh "sudo apt install maven -y"
           }
        }
        stage('checkout') {
             steps {
               sh "rm -rf hello-world-war_jenkins"
               sh "git clone https://github.com/patilsahana1234/hello-world-war_jenkins"
           }
        }
        stage('Deploy') {
             steps {
               sh "cp /var/lib/jenkins/workspace/hello_world_war/target/hello-world-war-1.0.0.war /opt/apache-tomcat-10.1.49/webapps"
           }
        }
    }
}


