pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '5e914210-5475-49f3-84f8-6d03a1442329'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
        REACT_APP_VERSION = "1.0.$BUILD_ID"
        REGION='asia-south1'
        PROJECT_ID = 'jenkins-435017'
    }

    stages {
        // This is a comment
        /*
        Multi
        line comments
        */
        stage('Build code') {
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

        stage('Build and push a Docker image with Cloud Build') {
            agent {
                docker { 
                    image 'gcr.io/google.com/cloudsdktool/google-cloud-cli:stable'
                    reuseNode true
                }
            }
            steps {
                withCredentials([file(credentialsId: 'gcp-secret-file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                        # Print the version of gcloud to ensure the CLI is working
                        gcloud version
                        
                        # Authenticate with the service account
                        gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                        
                        gcloud artifacts repositories list --project=$PROJECT_ID --location=$REGION

                        # gcloud artifacts repositories create react-app-repo --project=$PROJECT_ID --repository-format=docker \
                        # --location=$REGION --description="Docker repository from CLI"

                        gcloud builds submit --project=$PROJECT_ID --region=asia-east1 --tag $REGION-docker.pkg.dev/$PROJECT_ID/react-app-repo/react-image:tag1
                    '''
                }
            
            }
        }

        /*stage('Setup Google Cloud CLI') {
            environment {
                GCP_BUCKET = "jenkins-bucket-202409081110"
                CLOUDSDK_CORE_PROJECT = 'jenkins-435017'
            }
            agent {
                docker { 
                    image 'gcr.io/google.com/cloudsdktool/google-cloud-cli:stable'
                    reuseNode true
                }
            }
            steps {
                withCredentials([file(credentialsId: 'gcp-secret-file', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                        # Print the version of gcloud to ensure the CLI is working
                        gcloud version
                        
                        # Authenticate with the service account
                        gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
                        
                        # List the storage buckets
                        gcloud storage buckets list
                        
                        gcloud storage rsync build gs://$GCP_BUCKET --recursive

                        # Deploy the service and capture the operation ID
                        gcloud run deploy nginx-container-cloud-run \
                            --region=$REGION \
                            --port=80 \
                            --allow-unauthenticated \
                            --image=nginx:1.26-alpine 
                        
                        echo "Deployment Completed"
                    '''
                }
                sh '''
                    gcloud version
                    gcloud storage ls
                '''
            }
        }*/

        /*stage('Stage Tests'){
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
                                image 'my-playwright'
                                reuseNode true
                            }
                        }
                        steps {
                            sh '''
                                serve -s build &
                                sleep 10
                                npx playwright test --reporter=html
                            '''
                        }
                        post {
                            always {
                                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright E2E Report Local', reportTitles: '', useWrapperFileDirectly: true])
                            }
                        }
                    }
            }
        }*/ 

        /*stage('Deploy staging') {
            agent {
                docker { 
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli node-jq
                    node_modules/.bin/netlify --version
                    echo "Deploy to production site id : Site Id $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --json > deploy-output.json
                    
                '''
                script {
                    env.STAGING_URL = sh(script: "node_modules/.bin/node-jq -r '.deploy_url' deploy-output.json", returnStdout: true)
                }
            }
        }*/

        /*stage('Deploy Staging') {
            environment {
                CI_ENVIRONMENT_URL = 'STAGING_URL_TO_BE_SET'
            }
            agent {
                docker { 
                    image 'my-playwright'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    netlify --version
                    echo "Deploy to production site id : Site Id $NETLIFY_SITE_ID"
                    netlify status
                    netlify deploy --dir=build --json > deploy-output.json
                    CI_ENVIRONMENT_URL=$(jq -r '.deploy_url' deploy-output.json)
                    npx playwright test --reporter=html
                '''
            }
            post {
                always {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright E2E Report Staging', reportTitles: 'CUStom', useWrapperFileDirectly: true])
                }
            }
                    
        }*/

        /*stage('Approval') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    input message: 'Do you wish to deploy to production?', ok: 'Yes, I am sure!'
                }
            }
        }*/

        /*stage('Deploy prod') {
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
                    echo "Deploy to production site id : Site Id $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --prod
                '''
            }
        }*/

        /*stage('Deploy Prod') {
            environment {
                CI_ENVIRONMENT_URL = 'https://cheerful-cassata-6367ef.netlify.app'
            }
            agent {
                docker { 
                    image 'my-playwright'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    node --version
                    netlify --version
                    echo "Deploy to production site id : Site Id $NETLIFY_SITE_ID"
                    netlify status
                    netlify deploy --dir=build --prod
                    npx playwright test --reporter=html
                '''
            }
            post {
                always {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright E2E Report Prod', reportTitles: '', useWrapperFileDirectly: true])
                }
            }
                    
        }*/
    }

}