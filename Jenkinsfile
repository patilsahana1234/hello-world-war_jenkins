pipeline {
    // agent { label 'java' }
    agent none
    stages {
        stage('hello-world-war') {
        parallel {
        stage('checkout') {
            agent { label 'java' }
             steps {
               sh "rm -rf hello-world-war_jenkins"
               sh "git clone https://github.com/patilsahana1234/hello-world-war_jenkins"
           }
        }
        stage('Build') {
            agent { label 'java' }
             steps {
               sh "mvn clean package"
           }
        }
        
        stage('Deploy') {
            agent { label 'java' }
             steps {
               sh "sudo cp /home/slave1/workspace/Jenkins_pipeline/target/hello-world-war-1.0.0.war /opt/apache-tomcat-11.0.14/webapps/"
           }
        }
    }
}
        }
        }





