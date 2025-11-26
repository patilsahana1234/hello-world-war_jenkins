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
               sh "cp target/hello-world-war_jenkins.war /opt/apache-tomcat-10.1.49/webapps/"
           }
        }
    }
}


