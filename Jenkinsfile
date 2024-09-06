pipeline {
    agent any
    stages {
        // This is a comment
        /*
        Multi
        line comments
        */
        stage('Build') {
            agent {
                docker { 
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
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
        stage('Test') {
            agent {
                docker { 
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    echo "Test stage"
                    if [ -f build/index.html ]; then
                        echo "index.html exists."
                    else
                        echo "index.html does not exist."
                        exit 1
                    fi
                    npm test
                '''
            }
        }
    }
    post {
        always {
            junit 'test-results/junit.xml'
        }
    }
}