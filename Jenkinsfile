pipeline {
    agent any
    stages {
        // This is a comment
        /*
        Multi
        line comments
        */
        /*stage('Build') {
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
        }*/
        stage('Stage Tests'){
            parallel {
                stage('Unit test') {
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
                        post {
                            always {
                                junit 'jest-results/junit.xml'
                            }
                        }
                    }
                    stage('E2E') {
                        agent {
                            docker { 
                                image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                                reuseNode true
                            }
                        }
                        steps {
                            sh '''
                                npm install serve
                                node_modules/.bin/serve -s build &
                                sleep 10
                                npx playwright test --reporter=html
                            '''
                        }
                        post {
                            always {
                                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                            }
                        }
                    }
            }
        } 

        stage('Deploy') {
            agent {
                docker { 
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli
                    node_modules/.bin/netlify --version
                '''
            }
        }
    }

}