pipeline {
    agent none
    stages {
        stage('Build') {
            agent any
            steps {
                sh '''
                echo "From GIT Jenkins file"
                ls -la
                touch container_no.txt
                '''
            }
        }
    }
}