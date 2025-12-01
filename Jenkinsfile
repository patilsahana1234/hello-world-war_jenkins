pipeline {
    // agent { label 'java' }
    agent none
    parameters {
string(name: 'cmd', defaultValue: 'default', description: 'A sample string parameter')
booleanParam(name: 'SAMPLE_BOOLEAN', defaultValue: true, description: 'A boolean parameter')
choice(name: 'cmd1', choices: ['install', 'compile'], description: 'Choose one option')
}
    stages {
        stage('hello-world-war') {
        parallel {
        stage('checkout') {
            agent { label 'java' }
        steps {
                
                /* withCredentials([usernamePassword(
                            credentialsId: '18ebe766-3c6a-4e69-bcff-78285990d3a3',
                            usernameVariable: 'Sahana_USER',
                            passwordVariable: 'Sahana_PASS' */
                      withCredentials([sshUserPrivateKey(
                            credentialsId: '2d1bc43f-a959-47c9-900b-6e09bf6b154f',
                             keyFileVariable: 'Sahana_SSH_KEY',
                             usernameVariable: 'Sahana_SSH_USER' 
                        )])
            {
               sh "rm -rf hello-world-war_jenkins"
               sh "git clone https://github.com/patilsahana1234/hello-world-war_jenkins"
           }
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





