pipeline {
    agent none
    stages {
        stage('Build') {
            agent any
            steps {
                sh '''
                echo "BUILD start"
                ls -la
                node --version
                npm --version

                npm ci
                npm run build
                ls -la
                '''
            }
        }
    }
}